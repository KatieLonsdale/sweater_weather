class ForecastFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def weather_for_city
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  private

  def location_service
    @_location_service ||= LocationService.new(@location)
  end

  def location_info
    @_location_info ||= location_service.location_info
  end

  def lat
    @_lat ||= location_info.dig(:results, 0, :locations, 0, :latLng, :lat)
  end
  
  def lon
    @_lon ||= location_info.dig(:results, 0, :locations, 0, :latLng, :lng)
  end

  def weather_service
    @_weather_service ||= WeatherService.new(lat, lon)
  end

  def current_weather
    cw = weather_service.current_weather
    CurrentWeather.new(cw[:current])
  end

  def hourly_weather
    hw = weather_service.hourly_weather
    hw.dig(:forecast, :forecastday, 0, :hour).map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def daily_weather
    dw = weather_service.daily_weather
    dw.dig(:forecast, :forecastday).map do |day|
      DailyWeather.new(day)
    end
  end
end