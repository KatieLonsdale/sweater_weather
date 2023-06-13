class RoadTripFacade
  attr_reader :origin, :destination
  
  def initialize(details)
    @origin = details[:origin]
    @destination = details[:destination]
  end
end