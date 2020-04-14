class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end
  
  def edit
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end
  
  def create
    @user = User.new(params_user)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = "登録完了 メールで有効化をしてください"
      redirect_to login_url
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def update
    if @user.update_attributes(params_user_edit)
      flash[:success] = "プロフィールを編集しました"
      redirect_to current_user
    else
      flash.now[:danger] = "編集失敗"      
      render "users/edit"
    end
  end 
  
  def group
    @user = User.find(params[:id])
    ids = []
    Member.where(user_id: @user.id).each do |m|
      if m.activate == true
        ids.append(m.group_id)
      end
    end
    @groups = Group.where(id: ids).page(params[:page])
  end
  
  def favorites
    @user = User.find(params[:id])
    @microposts = @user.has_favorites.page(params[:page])
  end
  
  def follow
    @user = User.find(params[:id])
    @users = @user.followings
  end 
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end 
  
  def messages
    @user = User.find(params[:id])
    @messages = @user.send_messages.order(created_at: :desc)
  end
  
  def invited 
    @members = current_user.people.where(invited: true)
  end
  
  private
    def params_user
      params.require(:user).permit(:name, :age, :email, :password, :password_confirmation)
    end
    
    def params_user_edit
      params.require(:user).permit(:name, :age, :email, :password, :password_confirmation, :image)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user == @user
    end
end
