require 'test_helper'
require_relative '../../app/models/currency_model'

class CurrencyResponseTest < ActiveSupport::TestCase
  def setup
    @currency_data = { 'USD' => 1.0, 'EUR' => 0.85 }
    @currency_response = CurrencyResponse.new(@currency_data)
  end

  def test_currency_response_attributes
    assert_equal 'CoinSnark', @currency_response.api
    assert_equal 'https://rmottanet.gitbook.io/coinsnark/', @currency_response.api_documentation
    assert_equal 'https://raw.githubusercontent.com/rmottanet/coinsnark-api-rb/main/LICENSE', @currency_response.license
    assert_equal 'https://rmottanet.gitbook.io/coinsnark/coin-snark/coin-snak-api-terms-of-use', @currency_response.terms_of_use
    assert_not_nil @currency_response.timestamp
    assert_equal @currency_data, @currency_response.currency_data
  end

  def test_to_json_method
    json_data = @currency_response.to_json
    assert_equal 'CoinSnark', json_data[:api]
    assert_equal 'https://rmottanet.gitbook.io/coinsnark/', json_data[:api_documentation]
    assert_equal @currency_data, json_data[:currencies]
    assert_equal 'https://raw.githubusercontent.com/rmottanet/coinsnark-api-rb/main/LICENSE', json_data[:license]
    assert_equal 'https://rmottanet.gitbook.io/coinsnark/coin-snark/coin-snak-api-terms-of-use', json_data[:terms_of_use]
    assert_not_nil json_data[:timestamp]
  end
end
