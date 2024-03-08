require_relative 'api_model'

class ErrorResponse
  attr_reader :api, :api_documentation, :license, :terms_of_use, :timestamp, :error

  def initialize(error_message)
    @error = error_message
    set_api_info
  end

  def set_api_info
    api_response = ApiResponse.new

    @api = api_response.api
    @api_documentation = api_response.api_documentation
    @license = api_response.license
    @terms_of_use = api_response.terms_of_use
    @timestamp = api_response.timestamp
  end

  def to_json
    {
      api: @api,
      api_documentation: @api_documentation,
      error: @error,
      license: @license,
      terms_of_use: @terms_of_use,
      timestamp: @timestamp
    }
  end

end
