class ParticipatesController < ApplicationController
    before_action :require_login
    before_action {@plan = Plan.find(params[:plan_id])}
    before_action :group_member
    
    def index
        @participates = @plan.has_user
    end 
    
    def create
        @participate = current_user.participates.build(plan_id: @plan.id)
        if @participate.save
            flash[:success] = "参加しました"
            redirect_to @plan
        else
            flash.now[:danger] = "参加失敗"
            render "groups/plan"
        end
    end 
    
    def destroy
        @participate = Participate.find(params[:id])
        if @participate.destroy
            flash[:success] ="参加を取り消しました"
            redirect_to @plan
        else 
            flash[:danger] = "参加取り消しに失敗しました"
            redirect_to @plan
        end
    end 
    
 
end
