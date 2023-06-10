class WeatherService
  def self.current_weather(lat, lon)
    get_url("/v1/current.json?q=#{lat},#{lon}")
  end

  def self.daily_weather(lat, lon)
    get_url ("/v1/forecast.json?days=5&q=#{lat},#{lon}")
  end

  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com') do |site|
      site.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end