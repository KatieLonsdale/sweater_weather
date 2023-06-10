require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe '::current_weather' do
      it 'returns the weather api response for current weather for given lat/lon' do
        keys = [:last_updated, :temp_f, :feelslike_f, :humidity, :uv, :vis_miles, :condition]
        lat_lon = {latLng: {
          lat: 38.89037,
          lng: -77.03196
        }}
        cw = WeatherService.current_weather(lat_lon)

        expect(cw).to have_key(:current)
        keys.each do |key|
          expect(cw[:current]).to have_key(key)
        end
        expect(cw.dig(:current, :condition)).to have_key(:text)
        expect(cw.dig(:current, :condition)).to have_key(:icon)
      end
    end
  end
end