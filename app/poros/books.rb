class Books
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(data)
    @destination = data[:destination]
    @forecast = data[:forecast]
    @total_books_found = data[:total_books_found]
    @books = data[:books]
  end
end