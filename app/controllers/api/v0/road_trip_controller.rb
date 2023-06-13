class Api::V0::RoadTripController < ApplicationController
  before_action :verify_api_key, only: [:create]

  def create
    road_trip = RoadTripFacade.new(road_trip_params).create_road_trip
    if road_trip.nil?
      impossible_road_trip 
    else
      render json: RoadTripSerializer.new(road_trip)
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def verify_api_key
    if !params[:api_key].present? 
      missing_api_key 
    elsif !valid_api_key?
      wrong_api_key
    end
  end

  def valid_api_key?
    User.find_by(api_key: params[:api_key])
  end

  def missing_api_key
    render json: {error: {message: 'API key must be provided.'}}, status: 401
  end

  def wrong_api_key
    render json: {error: {message: 'API key invalid.'}}, status: 401
  end

  def impossible_road_trip
    render json: {error: {message: 'That road trip is impossible, sorry.'}}, status: 400
  end
end