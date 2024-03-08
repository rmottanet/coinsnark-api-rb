# test/helpers/cache_data_test.rb

require_relative '../../app/helpers/cache_data'
#require 'minitest/autorun'

#class CacheServiceTest < Minitest::Test
  #def setup
    #Rails.cache.clear
  #end

  #def test_save_and_retrieve_exchange_rates
    ## Dados de taxas de câmbio de exemplo
    #exchange_rates = { USD: 1.0, EUR: 0.85, GBP: 0.72 }

    ## Salvando taxas de câmbio no cache
    #CacheService.save_exchange_rates(exchange_rates)

    ## Recuperando taxas de câmbio do cache
    #retrieved_rates = CacheService.get_all_exchange_rates

    ## Verificando se os dados recuperados correspondem aos dados salvos
    #assert_equal exchange_rates, retrieved_rates
  #end

  #def test_retrieve_empty_cache
    ## Recuperando taxas de câmbio de um cache vazio
    #retrieved_rates = CacheService.get_all_exchange_rates

    ## Verificando se os dados recuperados estão vazios
    #assert_empty retrieved_rates
  #end
#end


require 'test_helper'

class CacheServiceTest < ActiveSupport::TestCase
  setup do
    Rails.cache.clear # Certifique-se de limpar o cache antes de cada teste
  end

  test "retrieve empty cache" do
    assert_empty CacheService.get_all_exchange_rates
  end

  test "save and retrieve exchange rates" do
    exchange_rates = { "USD" => 1.0, "EUR" => 0.8 }
    CacheService.save_exchange_rates(exchange_rates)

    cached_rates = CacheService.get_all_exchange_rates
    assert_equal exchange_rates, cached_rates
  end
end
