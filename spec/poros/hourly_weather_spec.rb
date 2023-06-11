require 'rails_helper'

RSpec.describe HourlyWeather do
  before(:all) do
    hourly_weather
    @hw = HourlyWeather.new(@data)
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@hw).to be_a(HourlyWeather)
        expect(@hw.time).to eq("12:00 AM")
        expect(@hw.temperature).to eq(62.8)
        expect(@hw.condition).to eq("Partly cloudy")
        expect(@hw.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")
      end
    end
  end
  describe 'instance methods' do
    describe '#format_time' do
      it 'turns a datetime into a formatted time' do
        expect(@hw.format_time("2023-06-10 00:00")).to eq("12:00 AM")
        expect(@hw.format_time("2023-06-10 14:00")).to eq("2:00 PM")
      end
    end
  end
end