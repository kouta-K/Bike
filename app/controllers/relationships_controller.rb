class RelationshipsController < ApplicationController
    before_action :require_login
    def create
        @user = User.find(params[:user_id])
        current_user.follow(@user)
        #current_user.notifications.create(visited_id: @user.id,relationship_id: @relationship.id, action: "フォロー")
        redirect_to @user
    end
    
    def destroy
        @user = User.find(params[:user_id])
        current_user.unfollow(@user)
        redirect_to @user
    end
end
