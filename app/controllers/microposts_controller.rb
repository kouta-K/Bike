class MicropostsController < ApplicationController
  before_action :require_login
  before_action :correct_user, only: [:destroy]
  before_action :image_or_content, only: [:create]
  def new
    @micropost = current_user.microposts.build
    3.times{@micropost.images.build}
  end

  def show
    @micropost = Micropost.find(params[:id])
    @microposts = Micropost.where(reply_id: params[:id])
    @reply_to = Micropost.find_by(id: @micropost.reply_id)
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if id = @micropost.reply_id
        @notification = Notification.new(user_id: current_user.id, micropost_id: id, visited_id: Micropost.find(id).user.id, action: "返信")
        @notification.save
        redirect_to micropost_url(id)
      else        
        redirect_to @micropost
      end
    else
      flash[:danger] = "投稿失敗"
      render "microposts/new"
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content, :reply_id, images_attributes: [:image])
    end
    
    def correct_user
      @micropost = Micropost.find(params[:id])
      unless correct_user?(@micropost.user)
        flash[:danger] = "削除できません"
        redirect_to root_url
      end 
    end
    
    def image_or_content
      if (params[:micropost][:content].empty?)
        if params[:micropost][:images_attributes].nil?
          flash[:danger] = "投稿の内容がありません"
          redirect_to new_micropost_path
        end
      end
    end
    
end
