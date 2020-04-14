class PasswordResetsController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  def new
  end

  def edit
  end
  
  def create 
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to login_url
    else
      
    end
  end
  
  def update 
    if params[:user][:password].empty?                  # (3) への対応
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)          # (4) への対応
      flash[:success] = "Password has been reset."
      redirect_to login_url
    else
      render 'edit'                                     # (2) への対応
    end
  end
  
  private
    def valid_user
      unless (@user && @user.activated? &&
              @user.reset_authenticated?(params[:id]))
        flash[:danger] = "無効なユーザー"
        redirect_to login_url
      end
    end
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def find_user
      @user = User.find_by(email: params[:email])
    end
    
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
