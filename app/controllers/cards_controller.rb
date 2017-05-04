class CardsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :find_story, only: [ :show, :new, :create ]

  def create
    @card = Card.new card_params
    @card.story = @story
    if @card.save
      flash[:success] = 'Create ok'
      redirect_to new_story_card_path(@story)
    else
      flash[:error] = 'Fail'
    end
  end

  def new
    @card = Card.new story: @story
  end

  def show
    @card = Card.find(params[:id])
  end

  private

  def find_story
    @story = Story.find_by id: params[:story_id]
  end

  def card_params
    params.require(:card).permit(:photo, :caption)
  end
end
