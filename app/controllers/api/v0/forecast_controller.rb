class Api::V0::ForecastController < ApplicationController
  def index
    @forecast = ForecastFacade.new(params[:location]).weather_for_city
  end
end