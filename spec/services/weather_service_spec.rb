require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe '::current_weather' do
      it 'returns the weather api response for current weather for given lat/lon' do
        keys = [:last_updated, :temp_f, :feelslike_f, :humidity, :uv, :vis_miles, :condition]
        lat = 38.89037
        lon = -77.03196
        cw = WeatherService.current_weather(lat, lon)

        expect(cw).to have_key(:current)
        keys.each do |key|
          expect(cw[:current]).to have_key(key)
        end
        expect(cw.dig(:current, :condition)).to have_key(:text)
        expect(cw.dig(:current, :condition)).to have_key(:icon)
      end
    end
    describe '::daily_weather' do
      it 'returns the weather api response for 5 days weather for given lat/lon' do
        lat = 38.89037
        lon = -77.03196
        dw = WeatherService.daily_weather(lat, lon)

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
    describe '::hourly_weather' do
      xit 'returns the weather api response for hourly weather for given lat/lon' do

      end
    end
  end
end