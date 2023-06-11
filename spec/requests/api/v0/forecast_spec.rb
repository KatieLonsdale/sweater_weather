require 'rails_helper'

RSpec.describe 'Forecast API' do
  before(:all) do
    get '/api/v0/forecast?location=cincinatti,oh'
    @data = JSON.parse(response.body, symbolize_names: true)
    @data_keys = [:id, :type, :attributes, :daily_weather, :hourly_weather]
    @attribute_keys = [:current_weather, :daily_weather, :hourly_weather]
    @cw_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
    @dw_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]
    @hw_keys = [:time, :temperature, :condition, :icon]

  end
  describe 'happy path' do
    describe 'retrieve forecast for given city' do
      it 'returns the current weather' do
        expect(response.status).to eq(200)
        @data_keys.each do |key|
          expect(@data).to have_key(key)
        end
        @attribute_keys.each do |key|
          expect(@data[:attributes]).to have_key(key)
        end
        @cw_keys.each do |key|
          expect(@data.dig(:attributes, :current_weather)).to have_key(key)
        end
        @dw_keys.each do |key|
          expect(@data.dig(:attributes, :daily_weather)).to have_key(key)
        end
        @hw_keys.each do |key|
          expect(@data.dig(:attributes, :hourly_weather)).to have_key(key)
        end

        expect(@data[:id]).to eq(nil)

        # test that unwanted data is not present
      end
    end
  end
end