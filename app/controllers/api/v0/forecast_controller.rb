class Api::V0::ForecastController < ApplicationController
  def index
    if params[:location].present?
      forecast = ForecastFacade.new(params[:location]).weather_for_city
      render json: ForecastSerializer.new(forecast)
    else
      bad_request_error
    end
  end

  private

  def bad_request_error
    render json: {errors: {detail: "Invalid search."}}, status: 400
  end
end