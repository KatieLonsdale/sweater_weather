class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

  def render_record_invalid_response(error)
    render json: {error: {message: error.message}}, status: 422
  end
end
