require 'rails_helper'

RSpec.describe 'Book endpoints' do
  describe 'search for book about location' do
    it 'returns 5 books about the given location', :vcr do
      get '/api/v1/book-search?location=denver,co&quantity=5'

      data = JSON.parse(response.body, symbolize_names: true)

      data_keys = [:id, :type, :attributes]
      attribute_keys = [:destination, :forecast, :total_books_found, :books]
      forecast_keys = [:summary, :temperature]
      books_keys = [:isbn, :title, :publisher]

      expect(response.status).to eq(200)

      data_keys.each do |key|
        expect(data[:data]).to have_key(key)
      end
      attribute_keys.each do |key|
        expect(data.dig(:data,:attributes)).to have_key(key)
      end
      forecast_keys.each do |key|
        expect(data.dig(:data, :attributes, :forecast)).to have_key(key)
      end
      books_keys.each do |key|
        expect(data.dig(:data, :attributes, :books, 0)).to have_key(key)
      end

      expect(data[:id]).to eq(nil)
      expect(data.dig(:data, :attributes, :books).count).to eq(5)
    end
  end
end