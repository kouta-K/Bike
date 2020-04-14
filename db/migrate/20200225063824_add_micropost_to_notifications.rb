class AddMicropostToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :micropost, foreign_key: true
  end
end
