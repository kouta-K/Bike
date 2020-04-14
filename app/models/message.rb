class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :content, length: {maximum: 255}
  validates :content_or_image, presence: true
  mount_uploader :image, ImageUploader
  
  private 
    def content_or_image
      content.presence or image.presence
    end
end
