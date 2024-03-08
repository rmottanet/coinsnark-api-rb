require 'test_helper'

class CurrencyControllerTest < ActionController::TestCase
  test "should get currency_names successfully" do
    # Simule os dados no cache
    cached_contents = { "USD" => "United States Dollar", "EUR" => "Euro", "GBP" => "British Pound Sterling" }
    Rails.cache.write('rates_cache', cached_contents)
    
    # Faça o mock do método read do cache para retornar os dados simulados
    Rails.cache.stub(:read, cached_contents) do
      get :currency_names
      assert_response :success
      
      # Verifique se a resposta contém apenas os nomes das moedas esperadas
      expected_response = { "USD" => "United States Dollar", "EUR" => "Euro", "GBP" => "British Pound Sterling" }
      assert_equal expected_response, JSON.parse(response.body)["currencies"]
    end
  end

  test "should handle error response from service" do
    # Simule uma exceção ocorrendo no serviço
    CurrencyService.stub(:get_currency_names_from_cache, ->(cache) { raise StandardError, "Failed to retrieve currency names from cache." }) do
      get :currency_names
      assert_response :internal_server_error
      assert_equal "Failed to retrieve currency names from cache.", JSON.parse(response.body)["error"]
    end
  end
end
