class Api::V0::ForecastController < ApplicationController
  def index
    @forecast = ForecastFacade.weather_for_city
  end
end