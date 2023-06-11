class LocationService
  attr_reader :location
  
  def initialize(location)
    @location = location
  end

  def location_info
    get_url("/geocoding/v1/address?location=#{@location}")
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |site|
      site.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end