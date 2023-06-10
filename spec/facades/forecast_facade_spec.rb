require 'rails_helper' do
  describe 'class methods' do
    describe '::weather_for_city' do
      it 'returns a forecast object with weather attributes' do
        forecast = ForecastFacade.weather_for_city('new york, ny')
        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather).to be_a(Hash)
        expect(forecast.daily_weather).to be_a(Hash)
        expect(forecast.hourly_weather).to be_a(Hash)
      end
    end
  end
end