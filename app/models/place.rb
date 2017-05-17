class Place < ApplicationRecord
  has_many :relationships, as: :followable
  has_many :followers, through: :relationships, source: :follower

  has_many :stories

  def thumbnail
    self.stories.sort_by{|s| s.unique_impression_count}[0].featured
  end
end
