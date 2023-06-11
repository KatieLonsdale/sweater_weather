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
        expect(forecast.daily_weather[0]).to be_a(DailyWeather)
        expect(forecast.hourly_weather).to be_a(Array)
        expect(forecast.hourly_weather[0]).to be_a(HourlyWeather)
      end
    end
  end
end