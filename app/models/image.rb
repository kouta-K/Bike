class Image < ApplicationRecord
    belongs_to :micropost, inverse_of: :images
    mount_uploader :image, ImageUploader
end
