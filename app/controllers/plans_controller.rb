class PlansController < ApplicationController
    before_action :require_login
    before_action :find_plan , only: [:show, :update, :destroy, :edit]
    before_action :group_member, only: [:new, :edit, :create, :update, :destroy]
    def index
        @plans = Plan.all
    end
    def new
        @plan = Plan.new
    end 
    
    def show
        @hash = Gmaps4rails.build_markers(@plan) do |plan, marker|
          marker.lat plan.latitude
          marker.lng plan.longitude
          marker.infowindow plan.place
        end
    end
    
    def edit 
    end
    
    def create
        @plan = @group.plans.build(plan_params)
        if @plan.save
            current_user.participates.create(plan_id: @plan.id)
            flash[:success] = "予定追加完了"
            redirect_to @plan
        else
            flash.now[:danger] = "予定追加失敗"
            render :new
        end
    end
    
    def update 
        if @plan.update_attributes(plan_params)
            flash[:success] = "編集しました"
            redirect_to @plan
        else 
            flash.now[:danger] = "編集に失敗しました"
            render "plans/edit"
        end
    end
    
    def destroy
        @plan.destroy
        redirect_to @group
    end
    
    private
        def plan_params
            params.require(:plan).permit(:datetime, :place, :content, :latitude, :longitude)
        end 
        
        def find_plan
            @plan = Plan.find(params[:id])
        end
    
end
