class Micropost < ApplicationRecord
  validates :content, length: {maximum: 255}
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  has_many :favorites
  has_many :notifications, dependent: :destroy
  
end
