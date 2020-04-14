class FavoritesController < ApplicationController
    before_action :require_login
    def create
        @favorite = current_user.favorites.build(micropost_id: params[:favorite][:micropost_id])
        if @favorite.save
            redirect_back(fallback_location: root_url)
        else 
            flash[:danger] = "フォロー失敗"
            redirect_to root_url
        end
    end 
    
    def destroy
        @favorite = Favorite.find(params[:id])
        @favorite.destroy
        redirect_back(fallback_location: root_url)
    end
end
    