require 'rails_helper'

RSpec.describe 'Forecast endpoints' do
  before(:all) do
    @data_keys = [:id, :type, :attributes]
    @attribute_keys = [:current_weather, :daily_weather, :hourly_weather]
    @cw_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
    @dw_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]
    @hw_keys = [:time, :temperature, :condition, :icon]
    
  end
  describe 'happy path' do
    describe 'retrieve forecast for given city' do
      it 'returns the current weather', :vcr do
        get '/api/v0/forecast?location=cincinatti,oh'
        @data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        @data_keys.each do |key|
          expect(@data[:data]).to have_key(key)
        end
        @attribute_keys.each do |key|
          expect(@data.dig(:data,:attributes)).to have_key(key)
        end
        @cw_keys.each do |key|
          expect(@data.dig(:data, :attributes, :current_weather)).to have_key(key)
        end
        @dw_keys.each do |key|
          expect(@data.dig(:data, :attributes, :daily_weather, 0)).to have_key(key)
        end
        @hw_keys.each do |key|
          expect(@data.dig(:data, :attributes, :hourly_weather, 0)).to have_key(key)
        end

        expect(@data[:id]).to eq(nil)

        expect(@data).to_not have_key(:location)
        expect(@data).to_not have_key(:forecast)
        expect(@data).to_not have_key(:current)

      end
    end
  end
  describe 'sad path' do
    it 'returns a 400 error if the query is blank' do
      get '/api/v0/forecast?location='

      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to be_a(Hash)
      expect(message[:errors][:detail]).to eq("Invalid search.")

      expect(message).to_not have_key(:id)
      expect(message).to_not have_key(:type)
      expect(message).to_not have_key(:attributes)
    end
  end
end