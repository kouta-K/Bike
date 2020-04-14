module GroupsHelper
    def group_activate_member?(group)
        if member = group.members.find_by(user_id: current_user.id)
            member.activate == true
        end
    end
    
    def admin_user?(group)
        group.user_id == current_user.id
    end
    
    #申請したかどうかは、レコードの存在だけで識別できる
    def send_request?(group)
        group.has_members.include?(current_user) 
    end
    
    def average_age(group)
        users = []
        group.members.where(activate: true).each do |user|
            users.append(User.find(user.user_id))
        end
        age = 0 
        users.each do |user|
            age += user.age
        end
        return age/users.count
    end
    
    
    def non_activate_members(group)
      users = @group.members.where(activate: false)
      @members = users.map{|user| User.find(user.user_id)}
    end
    
    
    def request_members(group)
        users = @group.members.where(activate: false, invited: false)
      @members = users.map{|user| User.find(user.user_id)}
    end
    
    def activate_group_count(user)
        user.people.where(activate: true).count
    end
    
    
    def member_url
        if request.path == admin_member_group_path(@group)
            "green3"
        else
            "black3"
        end
    end
    
    def request_url
        if request.path == requests_group_path(@group)
            "green3"
        else
            "black3"
        end
    end
    
    def edit_url
        if request.path == edit_group_path(@group)
            "green3"
        else
            "black3"
        end
    end
    
    def invited_url
        if request.path == invited_group_path(@group)
            "green3"
        else
            "black3"
        end
    end
end
