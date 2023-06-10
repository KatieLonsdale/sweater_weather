class WeatherService
  def self.current_weather(lat_lon)
    get_url("/v1/current.json?q=#{lat_lon.
    dig(:latLng, :lat)},#{lat_lon.dig(:latLng, :lon)}")
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