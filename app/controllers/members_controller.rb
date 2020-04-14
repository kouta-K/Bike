class MembersController < ApplicationController
    before_action :require_login
    before_action :admin_or_invited_user, only: [:update]
    before_action :presence_user, only: [:create]
    before_action :withdraw_or_rejection, only: [:destroy]
    def create
        if admin_user?(@group)
            user = User.find(params[:user_id])
            @member = @group.members.build(user_id: user.id, activate: false, invited: true)
            if @member.save
                current_user.notifications.create(visited_id: user.id, member_id: @member.id, action: "招待")
                flash[:success] = "#{user.name}を招待しました"
                redirect_to invited_group_path(@group)
            else 
                flash.now[:danger] = "招待失敗"
                render @group
            end
        else
            @member = @group.members.build(user_id: current_user.id, activate: false)
            if @member.save
                current_user.notifications.create(visited_id: @group.user_id, member_id: @member.id, action: "リクエスト")
                flash[:success] = "申請完了"
                redirect_to @group
            else
                flash.now[:danger] = "申請失敗"
                render "groups/index"
            end
        end
        
    end 
    
    def update
        if @member.update_attributes(activate: true, invited: false)
            if admin_user?(@group)
                current_user.notifications.create(visited_id: @member.user_id, member_id: @member.id, action: "承認")
                flash[:success] = "#{User.find(@member.user_id).name}を承認しました"
            else
                flash[:success] = "#{@group.name}に参加しました"
            end
            redirect_to @group
        else  
            flash[:danger] = "承認に失敗しました"
            redirect_to root_url
        end
    end
    
    def destroy
        if @member.activate == false
            flash[:success] = "取り消しました"
        else
            if current_user.id == @member.group.user_id
                flash[:success] = "#{@member.user.name}を退会させました"
            else
                flash[:success] = "退会しました"
            end
            plans = @member.user.participates
            plans.each do |plan| 
                plan.destroy
            end
        end
        @member.destroy
        redirect_back(fallback_location: root_url)
    end 
    
    private
        def admin_or_invited_user
            @group = Group.find(params[:group_id])
            @member = Member.find(params[:id])
            unless admin_user?(@group) || invited_user?(@member)
                redirect_to root_url
            end
        end
        
        def invited_user?(member)
            if member.invited == true && (member.user.id == current_user.id)
                return true
            else
                return false
            end 
        end
        
        def presence_user
            @group = Group.find(params[:group_id])
            if @group.has_members.include?(current_user) && !(admin_user?(@group))
                flash[:danger] = "参加しているか申請済みです"
                redirect_to groups_url
            end
        end
        
        def withdraw_or_rejection
            @member = Member.find_by(id: params[:id])
            if @member.activate == true
                if (current_user.id != @member.group.user_id) || (@member.group.user_id == @member.user_id)
                    if (@member.user_id != current_user.id) || (@member.group.user_id == @member.user_id)
                        flash[:danger] = "退会に失敗しました"
                        redirect_to root_url 
                    end
                end
            else
                if (@member.user_id != current_user.id) && (@member.group.user_id != current_user.id)
                    flash[:danger] = "権限がありません"
                    redirect_to root_url
                end
                
            end
        end
    
end
