require 'test_helper'
require_relative '../../app/models/conversion_model'

class ConversionResponseTest < ActiveSupport::TestCase
  test "to_json should return correct attributes" do
    conversion_data = { amount: 100, from: 'USD', to: 'EUR', result: 85.73 }
    conversion_response = ConversionResponse.new(conversion_data)

    expected_json = {
      api: 'CoinSnark',
      api_documentation: 'https://rmottanet.gitbook.io/coinsnark/',
      conversion: conversion_data,
      license: 'https://raw.githubusercontent.com/rmottanet/coinsnark-api-rb/main/LICENSE',
      terms_of_use: 'https://rmottanet.gitbook.io/coinsnark/coin-snark/coin-snak-api-terms-of-use',
      timestamp: Time.now.strftime('%Y-%m-%dT%H:%M:%S')
    }

    assert_equal expected_json, conversion_response.to_json
  end
end
