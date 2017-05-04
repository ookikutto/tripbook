class Story < ApplicationRecord
  belongs_to :place
  belongs_to :user

  has_many :cards

  def timeline
    cards.order( created_at: :asc)
  end
end
