require 'rails_helper'

RSpec.describe BooksService do
  describe 'instance methods' do
    describe '#search_by_location' do
      it 'searches for books with subject of given location', :vcr do
        bs = BooksService.new.search_by_location('denver+co')

        expect(bs).to have_key(:numFound)
        expect(bs).to have_key(:docs)
        expect(bs[:docs]).to be_a(Array)
        expect(bs.dig(:docs, 0)).to have_key(:title)
        expect(bs.dig(:docs, 0)).to have_key(:isbn)
        expect(bs.dig(:docs, 0)).to have_key(:publisher)
      end
    end
  end
end