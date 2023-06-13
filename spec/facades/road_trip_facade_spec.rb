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
end