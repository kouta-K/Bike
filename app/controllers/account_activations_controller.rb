class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(params[:id])
            user.update_attribute(:activated, true)
            user.update_attribute(:activated_at, Time.zone.now)
            login(user)
            flash[:success] = "アカウントを確認しました"
            redirect_to user
        else
            flash[:danger] = "無効なリンクです"
            redirect_to new_user_url
        end
    end
end
