require 'rails_helper'

RSpec.describe ForecastFacade do
  before(:all) do
    @ff = ForecastFacade.new('new york, ny')
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@ff).to be_a(ForecastFacade)
        expect(@ff.location).to eq('new york, ny')
      end
    end
  end
  describe 'instance methods' do
    describe '#weather_for_city' do
      it 'returns a forecast object with weather attributes', :vcr do
        forecast = @ff.weather_for_city
        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather).to be_a(CurrentWeather)
        expect(forecast.daily_weather).to be_a(Array)
        expect(forecast.daily_weather.count).to eq(3)
        expect(forecast.daily_weather[0]).to be_a(DailyWeather)
        expect(forecast.hourly_weather).to be_a(Array)
        expect(forecast.hourly_weather.count).to eq(24)
        expect(forecast.hourly_weather[0]).to be_a(HourlyWeather)
      end
    end
    describe '#weather_for_destination' do
       it 'returns an array of hourly forecasts', :vcr do
        forecast = @ff.weather_for_destination
        expect(forecast).to be_a(Array)
        expect(forecast.count).to eq(3)
       end
    end
    describe '#destination_time' do
      it 'returns the local time for location', :vcr do
        local_time = @ff.local_time
        expect(local_time).to be_a(DateTime)
      end
    end
  end
end