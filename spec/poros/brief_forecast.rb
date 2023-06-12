require 'rails_helper'

RSpec.describe BriefForecast do
  describe 'initialize' do
    it 'exists and has attributes' do
      forecast_data = {
      :temp_f=>60.6,
      :condition=>{:text=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png", :code=>1003}
      }

      bf = BriefForecast.new(forecast_data)

      expect(bf).to be_a(BriefForecast)
      expect(bf.summary).to eq("Partly cloudy")
      expect(bf.temperature).to eq(60.6)
    end
  end
end