class PlacesController < ApplicationController
  def show
    @place = Place.find_by id: params[:id]
    @lastest = Story.where(place: @place).order(created_at: :desc)
    @hostest = Story.where(place: @place).sort_by { |story| -story.unique_impression_count }
  end
end
