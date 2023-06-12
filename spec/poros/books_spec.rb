require 'rails_helper'

RSpec.describe Books do
  before(:all) do
    @forecast = BriefForecast.new({
      :temp_f=>60.6,
      :condition=>{:text=>"Partly cloudy"}
      })
    @book = Book.new({
      :title=>"Denver, Co",
      :isbn=>["0762507845", "9780762507849"],
      :publisher=>["Universal Map Enterprises"]
      })
    book_info = {destination: 'denver,co',
    forecast: @forecast,
    total_books_found: 170,
    books: [@book]
    }

    @books = Books.new(book_info)
  end
  describe '#initialize' do
    it 'exists and has attributes' do

      expect(@books).to be_a(Books)
      expect(@books.destination).to eq('denver,co')
      expect(@books.forecast).to eq(@forecast)
      expect(@books.forecast).to be_a(BriefForecast)
      expect(@books.total_books_found).to eq(170)
      expect(@books.books).to be_a(Array)
      expect(@books.books[0]).to eq(@book)
      expect(@books.books[0]).to be_a(Book)
    end
  end
end