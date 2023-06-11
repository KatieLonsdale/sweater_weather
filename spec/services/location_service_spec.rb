require 'rails_helper'

RSpec.describe LocationService do
  before(:all) do
    @ls = LocationService.new('washington,dc')
  end
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        expect(@ls).to be_a(LocationService)
        expect(@ls.location).to eq('washington,dc')
      end
    end
  end
  describe 'instance methods' do
    describe '#location_info' do
      it 'returns the mapquest geocode results searching by a given city', :vcr do
        lat_lon = @ls.location_info

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