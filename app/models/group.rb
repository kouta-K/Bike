class Group < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  #has_many :has_messages, through: :messages, source: :user
  has_many :plans, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :has_members, through: :members, source: :user
  validates :name, presence: true, length: {maximum: 25}
  validates :introduce, presence: true, length: {maximum: 255}
  validates :user_id, presence: true
  mount_uploader :image, ImageUploader
end
