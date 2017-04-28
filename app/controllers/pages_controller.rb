class PagesController < ApplicationController
  before_action :authenticate_user!, except: :landing

  def landing
    if current_user
      redirect_to home_path
    end
  end

  def home
    @image = Image.all.order(created_at: :desc)
  end

  def about
  end

end
