require 'rails_helper'

RSpec.describe Book do
  before(:all) do
    book_data = {
      :title=>"Denver, Co",
      :isbn=>["0762507845", "9780762507849"],
      :publisher=>["Universal Map Enterprises"]
      }

    @book = Book.new(book_data)
  end
  describe 'initialize' do
    it 'exists and has attributes' do
      expect(@book).to be_a(Book)
      expect(@book.isbn).to eq(["0762507845", "9780762507849"])
      expect(@book.title).to eq("Denver, Co")
      expect(@book.publisher).to eq(["Universal Map Enterprises"])
    end
  end
end