class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: "User" #フォローされている人のid
  has_many :notifications, dependent: :destroy

end
