class Place < ApplicationRecord
  has_many :relationships, as: :followable
  has_many :followers, through: :relationships, source: :follower

  has_many :stories
end
