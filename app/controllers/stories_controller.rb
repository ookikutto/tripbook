class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def show
  end

  def new
    @story = Story.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
