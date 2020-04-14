class SessionsController < ApplicationController
    before_action :require_login, only: [:destroy]
    before_action :already_login, only: [:new]
    def new 
        @errors = []
    end
    
    def create 
        email = params[:session][:email].downcase
        password = params[:session][:password]
        @user = User.find_by(email: email)
        errors_login(password, email)
        if @user && @user.authenticate(password) && !!@user.activated
            login(@user)
            flash[:success] = "ログイン成功"
            redirect_to @user
        else
            flash.now[:danger] = "ログイン失敗"
            
            render :new
        end
    end 
    
    def destroy
        logout
        redirect_to login_url
    end
    
    private
        def already_login
            unless session[:user_id].nil?
                redirect_to root_url
            end
        end
        
        def errors_login(password, email)
            @errors = []
            if email != ""
                if @user == nil
                    @errors << "メールアドレスが間違ってます"
                end
            else 
                @errors << "メールアドレスを入力してください"
            end
            
            if password != ""
                if @user
                    unless @user.authenticate(password)
                        @errors << "パスワードが間違っています"
                    end
                end
            else 
                @errors << "パスワードを入力してください"
            end
        end
    
end
