class NotificationsController < ApplicationController
  
  def index
    @notifications = Notification.where(visited_id: current_user.id).order(created_at: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
  
end
