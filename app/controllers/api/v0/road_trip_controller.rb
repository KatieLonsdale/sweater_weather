class Api::V0::RoadTripController < ApplicationController
  def create
    require 'pry'; binding.pry
    road_trip = RoadTripFacade.new(road_trip_params).create_road_trip
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end
end