class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

# def render_no_record_response
#   require 'pry'; binding.pry
#   render json: ErrorSerializer.error_message(error.message), status: :not_found
# end
end
