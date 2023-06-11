require 'rails_helper'

RSpec.describe DailyWeather do
  before(:all) do
    daily_weather
    @dw = DailyWeather.new(@data)
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@dw).to be_a(DailyWeather)
        expect(@dw.date).to eq("2023-06-10")
        expect(@dw.sunrise).to eq("05:25 AM")
        expect(@dw.sunset).to eq("08:26 PM")
        expect(@dw.max_temp).to eq(79.7)
        expect(@dw.min_temp).to eq(57.6)
        expect(@dw.condition).to eq("Patchy rain possible")
        expect(@dw.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/176.png")
      end
    end
  end
end