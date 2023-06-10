require 'rails_helper'

RSpec.describe LocationService do
  describe 'class methods' do
    describe '::location_info' do
      it 'returns the mapquest geocode results searching by a given city' do
        lat_lon = LocationService.location_info('washington,dc')

        expect(lat_lon.dig(:results, 0, :locations, 0)).to have_key(:latLng)
        expect(lat_lon.dig(:results, 0, :locations, 0, :latLng)).to be_a(Hash)
        expect(lat_lon.dig(:results, 0, :locations, 0, :latLng)).to have_key(:lat)
        expect(lat_lon.dig(:results, 0, :locations, 0, :latLng, :lat)).to be_a(Float)
        expect(lat_lon.dig(:results, 0, :locations, 0, :latLng)).to have_key(:lng)
        expect(lat_lon.dig(:results, 0, :locations, 0, :latLng, :lng)).to be_a(Float)
      end
    end
  end
end