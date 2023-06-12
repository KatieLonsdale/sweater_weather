require 'rails_helper'

RSpec.describe BooksFacade do
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        book = BooksFacade.new('denver,co')
        expect(book).to be_a(BooksFacade)
        expect(book.location).to eq('denver,co')
      end
    end
  end
  describe 'instance methods' do
    describe '#search_by_location' do
      it 'returns book object', :vcr do
        bf = BooksFacade.new('denver,co')
        books = bf.search_by_location(5)

        expect(books).to be_a(Books)
        expect(books.forecast).to be_a(BriefForecast)
        expect(books.destination).to eq('denver,co')
        expect(books.books.count).to eq(5)
      end
    end
  end
end