class Api::V1::BooksController < ApplicationController

  def search
    if params[:location].present?
      books = BooksFacade.new(params[:location]).search_by_location(params[:quantity].to_i)
      render json: BooksSerializer.new(books)
    else
      render json: {error:{message: "Validation failed: Location must be provided"}}, status: 422
    end
  end
end