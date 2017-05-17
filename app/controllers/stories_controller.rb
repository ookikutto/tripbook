class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :find_story, except: [ :new, :create ]
  before_action :authorize_user, except: [ :show, :new, :create ]

  before_action :log_impression, only: :show

  def show
    @story_comment = StoryComment.new
  end

  def new
    @story = Story.new
  end

  def create
    @place = Place.find_by name: place_params[:name], place_id: place_params[:place_id]
    if @place.nil?
      @place = Place.create place_params
    end
    @story = Story.new story_params
    @story.place = @place
    @story.user = current_user

    if @story.save
      redirect_to new_story_card_path(@story)
    else
      flash[:danger] = "Create story failed"
      redirect_to new_story_path
    end
  end

  def edit
  end

  def update
    @story.update_attributes story_params
    redirect_to edit_story_path(@story)
  end

  def destroy
    @story.destroy
    redirect_to home_path
  end

  private

  def authorize_user
    if @story.user.id != current_user.id
      redirect_to home_path
    end
  end

  def story_params
    params.require(:story).permit(:title, :featured)
  end

  def place_params
    params.require(:place).permit(:name, :place_id, :lat, :lng)
  end

  def find_story
    @story ||= Story.find_by id: params[:id]
    if @story.nil?
      redirect_to home_path
    end
  end

  def log_impression
    find_story
    if current_user
      @story.impressions.create(ip_address: request.remote_ip, user_id: current_user.id)
      # User also like that story for the recommendation (based on what user's see)
      current_user.like @story
    else
      @story.impressions.create(ip_address: request.remote_ip)
    end
  end
end
