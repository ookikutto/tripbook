class ImageComment < ApplicationRecord
  belongs_to :user
  belongs_to :image
end
