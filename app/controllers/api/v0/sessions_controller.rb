class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user
      raise ActiveRecord::RecordNotFound, "User not found."
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      invalid_user
    end
  end

  private

  def invalid_user
    render json: {error: {message: "Incorrect email or password."}}, status: 401
  end
end