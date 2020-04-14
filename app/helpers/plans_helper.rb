module PlansHelper
    def belongs_to_plan(plan)
        if current_user.participate_plan.include?(plan)
            "blue"
        else 
            "orange"
        end
    end
end
