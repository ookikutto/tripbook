class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :user
  has_many :image_comment, -> { order "created_at DESC"}
end
