require 'rails_helper'

RSpec.describe BooksFacade do
  before(:all) do
    @book = BooksFacade.new('denver,co', 5)
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@book).to be_a(BooksFacade)
        expect(@book.location).to eq('denver,co')
        expect(@book.quantity).to eq(5)
      end
    end
  end
  describe 'instance methods' do
    describe '#search_by_location' do
      it 'returns book object', :vcr do
        books = @book.search_by_location

        expect(books).to be_a(Books)
        expect(books.forecast).to be_a(BriefForecast)
        expect(books.destination).to eq('denver,co')
        expect(books.books.count).to eq(5)
      end
    end
  end
end