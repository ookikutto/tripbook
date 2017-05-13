class Impression < ApplicationRecord
  belongs_to :impressionable, polymorphic: true
end
