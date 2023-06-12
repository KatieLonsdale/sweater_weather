class BooksFacade
  attr_reader :location

  def initialize(location)
    @location = format_location(location)
  end

  def search_by_location(quantity)
    results = BooksService.new.search_by_location(@location)
    # need to parse location
    require 'pry'; binding.pry
  end

  private

  def format_location(location)
    location.gsub(/,/, '%20')
  end
end