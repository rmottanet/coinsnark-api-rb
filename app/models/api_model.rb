class ApiResponse
  attr_reader :api, :api_documentation, :license, :terms_of_use, :timestamp

  def initialize
    @api = 'CoinSnark'
    @api_documentation = 'https://rmottanet.gitbook.io/coinsnark/'
    @license = 'https://raw.githubusercontent.com/rmottanet/coinsnark-api-rb/main/LICENSE'
    @terms_of_use = 'https://rmottanet.gitbook.io/coinsnark/coin-snark/coin-snak-api-terms-of-use'
    @timestamp = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
  end

  def basic_info
    {
      api: @api,
      api_documentation: @api_documentation,
      license: @license,
      terms_of_use: @terms_of_use,
      timestamp: @timestamp
    }
  end
end
