require 'rails_helper'

RSpec.describe BooksFacade do
  describe 'class methods' do
    describe '::initialize' do
      it 'exists and has attributes' do
        book = BooksFacade.new('denver,co')
        expect(book).to be_a(BooksFacade)
        expect(book.location).to eq('denver,co')
      end
    end
  end
end