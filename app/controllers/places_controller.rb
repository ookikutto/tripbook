class PlacesController < ApplicationController
  def show
    @place = Place.find_by id: params[:id]
  end
end
