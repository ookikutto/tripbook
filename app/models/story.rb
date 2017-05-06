class Story < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :impressions, as: :impressionable

  has_many :cards

  def timeline
    cards.order( created_at: :asc)
  end

  def lastest_card
    cards.order( created_at: :asc).last
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
