class PagesController < ApplicationController
  before_action :authenticate_user!, except: :landing

  def landing
  end

  def home
  end

  def about
  end

end
