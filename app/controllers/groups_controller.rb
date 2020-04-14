class GroupsController < ApplicationController
  before_action :require_login
  before_action :group_admin, only: [:destroy, :requests, :edit, :admin_member]
  def index
    if params[:search] == "" || params[:search].nil?
        @groups = Group.all
    else
        @groups = Group.where(['name LIKE ?' ,"%#{params[:search]}%"])
    end
    
    if params[:option] == "2"
        @groups = @groups.order(created_at: :asc).page(params[:page])
    elsif params[:option] == "3"
        @groups = @groups.joins(:members).group(:group_id).order('count(members.user_id) desc').page(params[:page])
    else
        @groups = @groups.order(created_at: :desc).page(params[:page])
    end
  end
  
  
  def new
    @group = current_user.groups.build
  end
  
  def show
    @group = Group.find(params[:id])
    @plans = @group.plans.order(datetime: :desc).page(params[:page])
    @messages = @group.messages.order(created_at: :desc).page(params[:page])
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "編集しました"
      redirect_to @group
    else
      flash[:danger] = "編集に失敗しました"
      render "groups/edit"
    end
  end 
  
  def create
    @group = current_user.groups.build(group_params)
    if @group.save 
      @member = Member.new(user_id: @group.user_id, activate: true, group_id: @group.id)
      if @member.save
        flash[:success] = "作成成功"
        redirect_to groups_url
      end
    else
      flash.now[:danger] = "作成失敗"
      render :new
    end
  end
  
  def destroy
    @group.destroy
    flash[:success] = "グループを削除しました"
    redirect_to user_url(current_user.id)
  end
  
  def member
    @group = Group.find(params[:id])
    activate_members(@group)
  end
  
  def plans 
    @plans = @group.plans.order(datetime: :desc)
  end 
  
  def requests
    request_members(@group)
  end
  
  
  def admin_member
    @group = Group.find(params[:id])
  end
  
  def invited 
    @group = Group.find(params[:id])
    no_invited_group_user=[]
    @group.members.where(invited: false).each do |member|
      no_invited_group_user.append(member.user_id)
    end
    @users = User.where.not(id: no_invited_group_user).page(params[:page])
    #@users = Kaminari.paginate_array(users).page(params[:page])
  end
  
  private
    def group_params
      params.require(:group).permit(:name, :introduce, :image)
    end
    
    def activate_members(group)
      users = @group.members.where(activate: true)
      @members = users.map{|user| User.find(user.user_id)}
    end
    
    def group_admin
      @group = Group.find_by(id: params[:id])
      unless admin_user?(@group)
        redirect_to root_url
      end
    end

end
