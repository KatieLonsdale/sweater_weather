class Api::V1::BooksController < ApplicationController
  def search
    books = BooksFacade.new(params[:location]).search_by_location(params[:quantity].to_i)
    render json: BooksSerializer.new(books)
  end
end