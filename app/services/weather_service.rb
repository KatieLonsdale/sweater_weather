class WeatherService
  attr_reader :lat, :lon

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def current_weather
    get_url("/v1/current.json?q=#{@lat},#{@lon}")
  end

  def daily_weather
    get_url ("/v1/forecast.json?days=5&q=#{@lat},#{@lon}")
  end

  def hourly_weather
    get_url ("/v1/forecast.json?q=#{@lat},#{@lon}")
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |site|
      site.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end