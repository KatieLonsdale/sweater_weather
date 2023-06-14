require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        cw = WeatherService.new(38.89037, 77.03196)
        expect(cw).to be_a(WeatherService)
        expect(cw.lat).to eq(38.89037)
        expect(cw.lon).to eq(77.03196)
      end
    end
  end
  describe 'instance methods' do
    before(:all) do
      @ws = WeatherService.new(38.89037, -77.03196)
    end
    describe '#current_weather' do
      it 'returns the weather api response for current weather', :vcr do
        keys = [:last_updated, :temp_f, :feelslike_f, :humidity, :uv, :vis_miles, :condition]
        cw = @ws.current_weather

        expect(cw).to have_key(:current)
        keys.each do |key|
          expect(cw[:current]).to have_key(key)
        end
        expect(cw.dig(:current, :condition)).to have_key(:text)
        expect(cw.dig(:current, :condition)).to have_key(:icon)
      end
    end
    describe '#daily_weather' do
      it 'returns the weather api response for 5 days weather', :vcr do
        dw = @ws.daily_weather

        expect(dw.dig(:forecast, :forecastday, 0)).to have_key(:date)
        expect(dw.dig(:forecast, :forecastday, 0)).to have_key(:day)
        expect(dw.dig(:forecast, :forecastday, 0)).to have_key(:astro)
        expect(dw.dig(:forecast, :forecastday, 0, :day)).to have_key(:maxtemp_f)
        expect(dw.dig(:forecast, :forecastday, 0, :day)).to have_key(:mintemp_f)
        expect(dw.dig(:forecast, :forecastday, 0, :day)).to have_key(:condition)
        expect(dw.dig(:forecast, :forecastday, 0, :day, :condition)).to have_key(:text)
        expect(dw.dig(:forecast, :forecastday, 0, :day, :condition)).to have_key(:icon)
        expect(dw.dig(:forecast, :forecastday, 0, :astro)).to have_key(:sunrise)
        expect(dw.dig(:forecast, :forecastday, 0, :astro)).to have_key(:sunset)
      end
    end
    describe '#hourly_weather' do
      it 'returns the weather api response for hourly weather', :vcr do
        hw = @ws.hourly_weather

        expect(hw.dig(:forecast, :forecastday, 0)).to have_key(:hour)
        expect(hw.dig(:forecast, :forecastday, 0, :hour, 0)).to have_key(:time)
        expect(hw.dig(:forecast, :forecastday, 0, :hour, 0)).to have_key(:temp_f)
        expect(hw.dig(:forecast, :forecastday, 0, :hour, 0)).to have_key(:condition)
        expect(hw.dig(:forecast, :forecastday, 0, :hour, 0, :condition)).to have_key(:text)
        expect(hw.dig(:forecast, :forecastday, 0, :hour, 0, :condition)).to have_key(:icon)
      end
    end
    describe '#local_time' do
      it 'returns weather api response for local time endpoint', :vcr do
        local_time = @ws.local_time

        expect(local_time[:location]).to have_key(:localtime)
      end
    end
  end
end