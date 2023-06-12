class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  
  def render_record_invalid(error)
    render json: {error: {message: error.message}}, status: 422
  end
end
