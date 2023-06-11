require 'rails_helper'

RSpec.describe Forecast do
  before(:all) do
    forecast
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@forecast).to be_a(Forecast)
        expect(@forecast.current_weather).to be_a(CurrentWeather)
        expect(@forecast.daily_weather).to be_a(DailyWeather)
        expect(@forecast.hourly_weather).to be_a(HourlyWeather)
      end
    end
  end
end