require_relative '../models/conversion_model'
require_relative '../models/error_model'

class ConversionController < ApplicationController
  rescue_from StandardError, with: :handle_error

  def convert_currency
    from = params[:from].upcase if params[:from]
    to = params[:to].upcase if params[:to]
    amount = params[:amount]

    if from && to && amount
      begin
        conversion_data = ConversionService.convert_currency(from, to, amount)
        conversion_response = ConversionResponse.new(conversion_data)
        render json: conversion_response.to_json, status: :ok
      rescue StandardError => e
        render_error(e.message, :unprocessable_entity)
      end
    else
      render_error('Invalid parameters. Usage: /api/convert?from=<from_currency>&to=<to_currency>&amount=<amount>', :unprocessable_entity)
    end
  end

  private

  def handle_error(exception)
    render_error(exception.message, :internal_server_error)
  end

  def render_error(error_message, status)
    error_response = ErrorResponse.new(error_message)
    render json: error_response.to_json, status: status
  end
end
