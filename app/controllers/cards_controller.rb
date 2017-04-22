class CardsController < ApplicationController
  def create
    @card = Card.new card_params
    @card.story = Story.first
    puts @card.photo
    if @card.save
      flash[:success] = 'Create ok'
    else
      flash[:error] = 'Fail'
    end
  end

  def new
    @card = Card.new story: Story.first
  end

  def show
    @card = Card.find(params[:id])
  end

  private

  def card_params
    params.require(:card).permit(:photo, :caption, :prev, :next)
  end
end
