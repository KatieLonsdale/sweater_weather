class RoadTripFacade
  attr_reader :origin, :destination

  def initialize(details)
    @origin = details[:origin]
    @destination = details[:destination]
  end

  def create_road_trip
    RoadTrip.new(road_trip_info)
  end

  private

  def road_trip_service
    @_road_trip_service ||= RoadTripService.new
  end

  def weather_service
    @_weather_service ||= WeatherService.new
  end

  def get_road_trip
    @_road_trip ||= road_trip_service.get_road_trip(@origin, @destination)
  end

  def travel_time
    get_road_trip.dig(:route, :formattedTime)
  end

  def arrival_time_hour
    local_time = ForecastFacade.new(@destination).local_time
    local_time.hour + DateTime.parse(travel_time).hour
  end

  def weather_info
    hourly = ForecastFacade.new(@destination).weather_for_destination
    hourly[arrival_time_hour]
  end

  def road_trip_info
    {start_city: @origin,
    end_city: @destination,
    travel_time: travel_time,
    weather_at_eta: DestinationForecast.new(weather_info)
  }
  end
end