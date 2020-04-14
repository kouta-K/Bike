module UsersHelper
    def fav_url
        if request.path == favorites_user_path(@user)
            "green"
        else
            "black"
        end
    end
    
    def post_url
        if request.path == user_path(@user)
            "green"
        else
            "black"
        end
    end
    
end
