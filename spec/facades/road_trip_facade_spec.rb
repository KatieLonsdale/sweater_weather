require 'rails_helper'

RSpec.describe RoadTripFacade do
  before(:all) do
    details = {
      origin: "Cincinatti,OH", 
      destination: "Chicago,IL"
    }
    @rtf = RoadTripFacade.new(details)
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@rtf).to be_a(RoadTripFacade)
        expect(@rtf.origin).to eq("Cincinatti,OH")
        expect(@rtf.destination).to eq("Chicago,IL")
      end
    end
  end
  describe 'instance methods' do
    describe '#create_road_trip' do
      it 'creates a road trip object', :vcr do
        road_trip = @rtf.create_road_trip
        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to eq(@rtf.origin)
        expect(road_trip.end_city).to eq(@rtf.destination)
        expect(road_trip.weather_at_eta).to be_a(DestinationForecast)
      end
    end
  end
end