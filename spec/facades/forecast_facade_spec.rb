require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    describe '::weather_for_city' do
      it 'returns a forecast object with weather attributes', :vcr do
        forecast = ForecastFacade.weather_for_city('new york, ny')
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