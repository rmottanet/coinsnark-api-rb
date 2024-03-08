require_relative '../models/currency_model'
require_relative '../models/error_model'

class CurrencyController < ApplicationController
  rescue_from StandardError, with: :handle_error

  def currency_names
    begin

      currency_data = CurrencyService.get_currency_names_from_cache(Rails.cache)

      currency_response = CurrencyResponse.new(currency_data)

      render json: currency_response.to_json, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def handle_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end
end

