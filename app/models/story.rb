class Story < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :impressions, as: :impressionable
  has_many :cards, dependent: :destroy
  has_many :story_comments, -> { order "created_at DESC"}

  attr_accessor :trending, :most_recent

  def timeline
    cards.order(created_at: :asc)
  end

  def lastest_card
    cards.order(created_at: :desc).first
  end

  def oldest_card
    timeline.first
  end

  def impressions_count
    impressions.size
  end

  def unique_impression_count
    # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
    # so getting keys from the hash and calculating the number of keys
    impressions.group(:ip_address).size.keys.length
  end
end
