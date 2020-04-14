class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :visited, class_name: "User" #通知を受け取る人
  belongs_to :member, optional: true
  belongs_to :micropost, optional: true
  belongs_to :relationship, optional: true
  validates :user_id, presence: true
  validates :visited_id, presence: true
end
