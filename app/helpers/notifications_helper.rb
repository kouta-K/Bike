module NotificationsHelper
    def unchecked_notification?
        if current_user.visited_user.where(checked: false).empty?
            return false
        else
            return true
        end
    end
    
    def which_action(notification)
        if notification.action == "リクエスト"
            link_to notification.member.group.name, requests_group_path(notification.member.group)
        elsif notification.action == "返信"
            link_to "投稿", notification.micropost 
        elsif notification.action == "承認"
            link_to notification.member.group.name, notification.member.group 
        elsif notification.action == "招待"
            link_to notification.member.group.name, notification.member.group
        else
            link_to "あなた", User.find(notification.visited_id)
        end
    end
    
    def particle(notification)
        if notification.action == "フォロー"
            "を"
        elsif notification.action == "承認"
            "への申請を"
        else
            "に"
        end
    end
    
    def which_icon(notification)
        if notification.action == "リクエスト"
            render html: '<i class="fas fa-users"></i>'.html_safe
        elsif notification.action == "返信"
            render html: '<i class="far fa-comment"></i>'.html_safe
        elsif notification.action == "承認"
            render html: '<i class="far fa-check-circle"></i>'.html_safe
        elsif notification.action == "招待"
            render html: '<i class="fas fa-hands-helping"></i>'.html_safe
        else 
            render html: '<i class="fa fa-star star-favorite"></i>'.html_safe
        end
    end
end
