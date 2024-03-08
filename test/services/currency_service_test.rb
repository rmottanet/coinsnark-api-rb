# test/services/currency_service_test.rb
require 'test_helper'

class CurrencyServiceTest < ActiveSupport::TestCase
  test "should return currency names from cache" do
    # Mock cache object
    cache = ActiveSupport::Cache::MemoryStore.new

    # Mock cached contents
    cached_contents = {
      "USD" => 1.0,
      "EUR" => 0.85,
      "GBP" => 0.75
    }

    # Stub cache.read method to return cached contents
    cache.stub(:read, cached_contents) do
      currency_names = CurrencyService.get_currency_names_from_cache(cache)
      assert_equal 3, currency_names.size
      assert_equal "United States Dollar", currency_names["USD"]
      assert_equal "Euro", currency_names["EUR"]
      assert_equal "British Pound Sterling", currency_names["GBP"]
    end
  end

  test "should return empty hash when cache is empty" do
    # Mock empty cache object
    cache = ActiveSupport::Cache::MemoryStore.new

    # Stub cache.read method to return nil (empty cache)
    cache.stub(:read, nil) do
      currency_names = CurrencyService.get_currency_names_from_cache(cache)
      assert_empty currency_names
    end
  end

  test "should raise error when cache retrieval fails" do
    # Mock cache object with failing read method
    cache = ActiveSupport::Cache::MemoryStore.new
    cache.stub(:read, -> { raise StandardError, "Cache retrieval failed" }) do
      assert_raises(StandardError) do
        CurrencyService.get_currency_names_from_cache(cache)
      end
    end
  end
end
