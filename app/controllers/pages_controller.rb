class PagesController < ApplicationController
  # layout 'landing-layout'
  before_action :authenticate_user!, except: :landing

  def landing
  end

  def home
  end

  def about
  end

end
