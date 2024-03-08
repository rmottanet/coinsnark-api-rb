require_relative '../models/error_model'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found
    error_response = ErrorResponse.new('Route not found')
    render json: error_response.to_json, status: :not_found
  end
end

