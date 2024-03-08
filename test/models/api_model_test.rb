require 'test_helper'

class ApiResponseTest < ActiveSupport::TestCase
  test "basic info should return correct attributes" do
    api_response = ApiResponse.new

    expected_basic_info = {
      api: 'CoinSnark',
      api_documentation: 'https://rmottanet.gitbook.io/coinsnark/',
      license: 'https://raw.githubusercontent.com/rmottanet/coinsnark-api-rb/main/LICENSE',
      terms_of_use: 'https://rmottanet.gitbook.io/coinsnark/coin-snark/coin-snak-api-terms-of-use',
      timestamp: Time.now.strftime('%Y-%m-%dT%H:%M:%S')
    }

    assert_equal expected_basic_info, api_response.basic_info
  end
end
