class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user || !user.authenticate(params[:password])
      invalid_user
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    end
  end

  private

  def invalid_user
    render json: {error: {message: "Incorrect email or password."}}, status: 401
  end
end