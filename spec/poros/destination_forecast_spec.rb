require 'rails_helper'

RSpec.describe DestinationForecast do
  before(:all) do
    weather_info =  {
    :time=>"2023-06-13 14:00",
    :temp_f=>61.0,
    :condition=>{:text=>"Light rain shower"}
  }

    @df = DestinationForecast.new(weather_info)
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@df).to be_a(DestinationForecast)
        expect(@df.datetime).to eq("2023-06-13 14:00")
        expect(@df.temperature).to eq(61.0)
        expect(@df.condition).to eq("Light rain shower")
      end
    end
  end
end