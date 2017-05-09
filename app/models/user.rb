class User < ApplicationRecord
  # Remove the default :validatable and add :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  has_many :identities

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
end
