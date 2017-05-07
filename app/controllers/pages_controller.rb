class PagesController < ApplicationController
  before_action :authenticate_user!, except: :landing

  def landing
    if current_user
      redirect_to home_path
    end
    @trendings = TrendingStory.get
  end

  def home
    @feeds = current_user.feed
  end

  def about
  end

end
