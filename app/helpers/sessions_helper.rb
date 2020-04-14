module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def login(user)
        session[:user_id] = user.id
    end
    
    def login?
        !!current_user
    end
    
    def logout
        session.delete(:user_id) if login?
        @current_user = nil
    end
    
    def correct_user?(user)
        if current_user == user
            return true
        else
            return false
        end
    end
end
