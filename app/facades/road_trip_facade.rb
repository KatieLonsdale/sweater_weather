class RoadTripFacade
  attr_reader :origin, :destination

  def initialize(details)
    @origin = details[:origin]
    @destination = details[:destination]
  end

  def create_road_trip
    unless get_road_trip.nil?
      RoadTrip.new(road_trip_info)
    end
  end

  private

  def road_trip_service
    @_road_trip_service ||= RoadTripService.new
  end

  def get_road_trip
    @_road_trip ||= road_trip_service.get_road_trip(@origin, @destination)
    @_road_trip.dig(:info, :statuscode) == 402 ? nil : @_road_trip
  end

  def travel_time
    get_road_trip.dig(:route, :formattedTime)
  end

  def hours_ahead
    hours = travel_time.split(':').first
    hours.to_i % 24
  end

  def days_ahead
    hours = travel_time.split(':').first
    (hours.to_i + local_time.hour) / 24
  end

  def local_time
    @_local_time = ForecastFacade.new(@destination).local_time
  end

  def arrival_time_hour
    (local_time.hour + hours_ahead) % 24
  end

  def weather_info
    daily = ForecastFacade.new(@destination).weather_for_destination
    daily.dig(days_ahead, :hour, arrival_time_hour)
  end

  def road_trip_info
    {start_city: @origin,
    end_city: @destination,
    travel_time: travel_time,
    weather_at_eta: DestinationForecast.new(weather_info)
  }
  end
end