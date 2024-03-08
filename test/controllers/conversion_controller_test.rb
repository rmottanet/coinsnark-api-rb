require 'test_helper'

class ConversionControllerTest < ActionController::TestCase
  test "should convert currency successfully" do
    valid_params = { from: "USD", to: "EUR", amount: 100 }
    expected_response_keys = %w(api api_documentation conversion license terms_of_use timestamp)
    
    ConversionService.stub(:convert_currency, 83.6) do
      get :convert_currency, params: valid_params
      assert_response :success
      
      assert_response_keys(expected_response_keys)
    end
  end

  test "should handle missing parameters" do
    missing_params = { from: "USD", to: "EUR" }
    expected_response_keys = %w(api api_documentation error license terms_of_use timestamp)
    
    get :convert_currency, params: missing_params
    assert_response :unprocessable_entity
    
    assert_response_keys(expected_response_keys)
    assert_equal "Invalid parameters. Usage: /api/convert?from=<from_currency>&to=<to_currency>&amount=<amount>", json_response["error"]
  end

  test "should handle conversion error" do
    error_message = "Failed to convert currency."
    ConversionService.stub(:convert_currency, ->(_, _, _) { raise StandardError, error_message }) do
      get :convert_currency, params: { from: "USD", to: "EUR", amount: 100 }
      assert_response :unprocessable_entity
      
      assert_response_keys(%w(api api_documentation error license terms_of_use timestamp))
      assert_equal error_message, json_response["error"]
    end
  end

  private

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def assert_response_keys(keys)
    assert_equal keys.sort, json_response.keys.sort
  end
end
