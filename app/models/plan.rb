class Plan < ApplicationRecord
  belongs_to :group
  validates :place, presence: true
  validates :datetime, presence: true
  validates :content, presence: true, length: {maximum: 255}
  has_many :participater, class_name: "Participate", dependent: :destroy
  has_many :has_user, through: :participater, source: :user
  geocoded_by :place
  after_validation :geocode
end
