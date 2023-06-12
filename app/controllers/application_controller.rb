class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  
  def render_record_invalid(error)
    render json: {error: {message: error.message}}, status: 422
  end

  def render_record_not_found(error)
    render json: {error: {message: error.message}}, status: 404
  end
end
