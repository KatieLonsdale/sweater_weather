class RoadTripService
  def road_trip(origin, destination)
    get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |site|
      site.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end