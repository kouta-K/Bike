module ParticipatesHelper
    def participate_user?(participaters)
        participaters.include?(current_user)
    end

end
