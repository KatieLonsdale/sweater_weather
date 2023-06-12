class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    render json: UserSerializer.new(user)
  end
end