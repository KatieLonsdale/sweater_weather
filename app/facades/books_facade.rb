class BooksFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def search_by_location(quantity)
    @quantity = quantity
    Books.new(format_books_data)
  end

  private

  def results
    BooksService.new.search_by_location(format_location)
  end

  def format_location
    @location.gsub(/,/, '+')
  end

  def format_books_data
    {destination: @location,
    forecast: forecast,
    total_books_found: results[:numFound],
    books: create_books
  }
  end

  def create_books
    books = []
    i = 0
    results[:docs].each do |book|
      break if i == @quantity
      books << Book.new(book)
      i += 1
    end
    books
  end

  def forecast
    data = WeatherService.new(lat, lon).current_weather[:current]
    BriefForecast.new(data)
  end

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
end