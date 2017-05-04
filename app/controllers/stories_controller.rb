class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def show
  end

  def new
    @story = Story.new
  end

  def create
    @place = Place.find_or_create_by name: place_params[:name]
    @story = Story.new story_params
    @story.place = @place
    @story.user = current_user

    if @story.save
      redirect_to new_story_card_path(@story)
    else
      puts @story.errors.full_messages.to_sentence
      flash[:danger] = "Create story failed"
      redirect_to new_story_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def story_params
    params.require(:story).permit(:title, :featured)
  end

  def place_params
    params.require(:place).permit(:name)
  end

end
