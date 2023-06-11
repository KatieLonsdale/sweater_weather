class ForecastFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def weather_for_city
    # look up lat/lon for given location
    lat_lon = LocationService.location_info(@location)
    lat = lat_lon.dig(:results, 0, :locations, 0, :latLng, :lat)
    lon = lat_lon.dig(:results, 0, :locations, 0, :latLng, :lng)
    # send lat/lon to weather service(3)
    cw = WeatherService.new(lat, lon).current_weather
    dw = WeatherService.new(lat, lon).daily_weather
    hw = WeatherService.new(lat, lon).hourly_weather
    # create cw, hw, dw objects with weather service returns
    cwo = CurrentWeather.new(cw[:current])
    dwo = dw.dig(:forecast, :forecastday).map do |day|
      DailyWeather.new(day)
    end
    hwo = hw.dig(:forecast, :forecastday, 0, :hour).map do |hour|
      HourlyWeather.new(hour)
    end
    # create forecast object with cw, hw, dw as attributes
    Forecast.new(cwo, dwo, hwo)
  end
end