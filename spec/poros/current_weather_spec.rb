require 'rails_helper'

RSpec.describe CurrentWeather do
  before(:all) do
    current_weather
    @cw = CurrentWeather.new(@data)
  end
  describe 'class methods' do
    describe 'initialize' do
      it 'exists and has attributes' do
        expect(@cw).to be_a(CurrentWeather)
        expect(@cw.last_updated).to eq("2023-06-10 20:00")
        expect(@cw.temperature).to eq(75.0)
        expect(@cw.feels_like).to eq(76.9)
        expect(@cw.humidity).to eq(37)
        expect(@cw.uvi).to eq(6.0)
        expect(@cw.visibility).to eq(8.0)
        expect(@cw.condition).to eq("Partly cloudy")
        expect(@cw.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")
      end
    end
  end
end