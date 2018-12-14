class ApplicationController < ActionController::Base
  def render_error(error_key, http_status)
    error = ErrorHandler.json_for(error_key)
    render json: error, status: http_status
  end
end
