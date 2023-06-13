require 'rails_helper'

RSpec.describe RoadTrip do
  before(:all) do
    weather_info = {
    :time=>"2023-06-13 14:00",
    :temp_f=>61.0,
    :condition=>{:text=>"Light rain shower"}
    }
    @df = DestinationForecast.new(weather_info)
    rt_info = {
      start_city: 'cincinatti, oh',
      end_city: 'chicago, il',
      travel_time: "04:20:37",
      weather_at_eta: @df
    }
    @road_trip = RoadTrip.new(rt_info)
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@road_trip).to be_a(RoadTrip)
        expect(@road_trip.start_city).to eq('cincinatti, oh')
        expect(@road_trip.end_city).to eq('chicago, il')
        expect(@road_trip.travel_time).to eq("04:20:37")
        expect(@road_trip.weather_at_eta).to eq(@df)
      end
    end
  end
end