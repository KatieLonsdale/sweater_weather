class Api::V1::BooksController < ApplicationController

  def search
    if params[:location].present?
      books = BooksFacade.new(params[:location], quantity).search_by_location
      render json: BooksSerializer.new(books)
    else
      render json: {error:{message: "Validation failed: Location must be provided"}}, status: 422
    end
  end

  private

  def quantity
    if params[:quantity].present? && params[:quantity].to_i > 0
      params[:quantity].to_i
    else
      3
    end
  end
end