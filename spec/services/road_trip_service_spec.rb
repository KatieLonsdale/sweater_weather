require 'rails_helper'

RSpec.describe RoadTripService do
  describe 'instance methods' do
    describe 'get_road_trip' do
      it 'returns MapQuest road trip info', :vcr do
        road_trip = RoadTripService.new.get_road_trip("Cincinatti,OH", "Chicago,IL")

        expect(road_trip[:route]).to have_key(:formattedTime)
      end
    end
  end
end