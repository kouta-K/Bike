class ApplicationController < ActionController::Base
    include SessionsHelper
    include GroupsHelper
    before_action :belongs_to_plans
    def require_login
        redirect_to login_path unless login?
    end
    
    def group_member
        if @plan.nil?
            @group = Group.find_by(id: params[:group_id]) || Group.find_by(id: params[:id])
        else
            @group = Group.find(@plan.group_id)
        end
        unless group_activate_member?(@group)
            flash[:danger] = "グループに参加していません"
            redirect_to groups_url
        end
    end
    
    def belongs_to_plans
        plans=[]
        unless session[:user_id].nil?
            current_user.people.where(activate: true).each do |member|
                member.group.plans.each do |plan|
                    plans.append(plan)
                end
            end
        end
        @all_plans = plans
    end
end
