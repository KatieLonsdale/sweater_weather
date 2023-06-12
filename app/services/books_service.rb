class BooksService
  def search_by_location(location)
    get_url("/search.json?q=#{location}")
  end

  def conn
    Faraday.new(url: 'https://openlibrary.org') do |site|
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end