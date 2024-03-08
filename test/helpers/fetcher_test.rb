require_relative '../../app/helpers/fetcher'

require 'test_helper'

class FetcherTest < ActiveSupport::TestCase
  test "fetch data from URL" do
    # URL de teste
    url = "https://api.example.com/data"

    # Dados de exemplo a serem retornados pela URL
    sample_data = { key: "value" }.to_json

    # Mock da resposta da requisição HTTP
    http_response = OpenStruct.new(body: sample_data)
    Net::HTTP.stub(:get_response, http_response) do
      fetched_data = Fetcher.fetch_data(url)
      assert_equal JSON.parse(sample_data), fetched_data
    end
  end

  test "handle errors gracefully" do
    # URL inválida para provocar um erro
    invalid_url = "https://api.example.com/invalid"

    # Mock de um erro ao fazer a requisição HTTP
    Net::HTTP.stub(:get_response, ->(url) { raise StandardError }) do
      fetched_data = Fetcher.fetch_data(invalid_url)
      assert_nil fetched_data
    end
  end
end
