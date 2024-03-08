require 'test_helper'
require 'webmock/minitest'
require_relative '../../app/integrations/bcb_quotes'

class BCBQuotesTest < ActiveSupport::TestCase
  def setup
    # Simula uma resposta da API do BCB
    @sample_response_body = {
      "conteudo" => [
        { "moeda" => "Dólar", "valorCompra" => 5.0 },
        { "moeda" => "Euro", "valorCompra" => 6.0 }
      ]
    }.to_json

    # Configura a resposta da API para o método Net::HTTP.get_response
    stub_request(:any, BCBQuotes::API_URL).to_return(body: @sample_response_body, status: 200)
  end

  def test_get_exchange_rates
    # Chama o método que busca as taxas de câmbio
    exchange_rates = BCBQuotes.get_exchange_rates

    # Verifica se as taxas foram retornadas corretamente
    assert_equal 1, exchange_rates["USD"]
    assert_equal 5.0, exchange_rates["BRL"]
    assert_equal 0.8333, exchange_rates["EUR"].round(4) 
  end
end
