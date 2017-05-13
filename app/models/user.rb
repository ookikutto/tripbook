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

  def feeds_from_following
    following_user_ids = "SELECT followable_id FROM relationships
      WHERE follower_id = :user_id AND followable_type = :user_class_name"
    following_place_ids = "SELECT followable_id FROM relationships
      WHERE follower_id = :user_id AND followable_type = :place_class_name"
    Story.where("(user_id IN (#{following_user_ids})) OR
      (place_id IN (#{following_place_ids}))",
      user_id: id, user_class_name: 'User', place_class_name: 'Place')
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

  def feed
    @feed_stories = []

    # TRENDING
    trendings = TrendingStory.get.map do |story|
      result = {}
      result[:trending] = true
      result[:id] = story.id
      result
    end
    @feed_stories.concat trendings

    # MOST RECENT
    most_recents = Story.order(created_at: :desc).limit(10).map do |story|
      result = {}
      result[:most_recent] = true
      result[:id] = story.id
      result
    end
    # Choose distinct story from the ones that already in feed_stories
    most_recents.select! do |story|
      result = @feed_stories.detect { |fs| fs[:id] == story[:id] }
      result.nil?
    end
    # Add to feed_stories
    @feed_stories.concat most_recents

    # FROM FOLLOW
    from_follows = []
    @feed_stories.concat from_follows

    # SHUFFLE THE RESULT
    @feed_stories.shuffle.map do |st|
      result = Story.find st[:id]
      result.trending = st[:trending]
      result.most_recent = st[:most_recent]
      result
    end
  end

  private

  def source_type something
    something.class.name.demodulize.downcase
  end
end
