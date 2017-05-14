class User < ApplicationRecord
  # Remove the default :validatable and add :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  has_many :identities

  has_many :stories

  # FOLLOW
  has_many :passive_relationships, class_name: 'Relationship',
    dependent: :destroy, as: :followable
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_relationships, class_name: 'Relationship',
    foreign_key: 'follower_id', dependent: :destroy
  has_many :following_users, through: :active_relationships, source: :followable,
    source_type: 'User'
  has_many :following_places, through: :active_relationships, source: :followable,
    source_type: 'Place'

  def follow(something)
    self.send("following_#{source_type something}s") << something
  end

  def unfollow(something)
    self.send("following_#{source_type something}s").delete(something)
  end

  def follow?(something)
    self.send("following_#{source_type something}s").include?(something)
  end

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end

  def feeds
    @feed_stories = []

    # TRENDING
    trending_story_ids = TrendingStory.get_ids
    @feed_stories.concat trending_story_ids

    # MOST RECENT
    most_recent_story_ids = Story.order(created_at: :desc).limit(10).map(&:id)
    @feed_stories.concat most_recent_story_ids

    # FROM FOLLOW
    @feed_stories.concat from_following_story_ids

    Story.where("id IN (?)", @feed_stories).order(created_at: :desc)
  end

  private

  def from_following_story_ids
    following_user_ids = "SELECT followable_id FROM relationships
      WHERE follower_id = :user_id AND followable_type = :user_class_name"
    following_place_ids = "SELECT followable_id FROM relationships
      WHERE follower_id = :user_id AND followable_type = :place_class_name"
    Story.where("(user_id IN (#{following_user_ids})) OR
      (place_id IN (#{following_place_ids}))",
      user_id: id, user_class_name: 'User', place_class_name: 'Place')
      .map(&:id)
  end

  def source_type something
    something.class.name.demodulize.downcase
  end
end
