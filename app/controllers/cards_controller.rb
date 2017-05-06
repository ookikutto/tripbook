class CardsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :find_story
  before_action :find_card, only: [ :edit, :update, :destroy ]

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

  def edit
  end

  def update
    @card.update_attributes card_params
    redirect_to edit_story_card_path(@story, @card)
  end

  def destroy
    @card.destroy
    if @story.cards.empty?
      redirect_to new_story_card_path(@story)
    else
      redirect_to edit_story_card_path(@story, @story.lastest_card)
    end
  end

  private

  def find_story
    @story = Story.find_by id: params[:story_id]
    if @story.nil?
      redirect_to home_path
    end
  end

  def find_card
    @card = Card.find_by id: params[:id]
    if @card.nil?
      redirect_to home_path
    end
  end

  def card_params
    params.require(:card).permit(:photo, :caption)
  end
end
