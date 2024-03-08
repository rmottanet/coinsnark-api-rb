# test/services/conversion_service_test.rb
require 'test_helper'

class ConversionServiceTest < ActiveSupport::TestCase
  test "should convert currency successfully" do
    # Simulate exchange rates in cache
    exchange_rates = { "USD" => 1.0, "EUR" => 0.85, "GBP" => 0.75 }
    CacheService.stub(:get_all_exchange_rates, exchange_rates) do
      conversion_info = ConversionService.convert_currency("USD", "EUR", 100)
      assert_equal "USD", conversion_info[:from]
      assert_equal "EUR", conversion_info[:to]
      assert_equal 85.0, conversion_info[:converted]
      assert_not_nil conversion_info[:cache_updated]
    end
  end

  test "should raise error for missing currency codes" do
    # Simulate exchange rates in cache
    exchange_rates = { "USD" => 1.0, "EUR" => 0.85, "GBP" => 0.75 }
    CacheService.stub(:get_all_exchange_rates, exchange_rates) do
      assert_raises(StandardError) do
        ConversionService.convert_currency("USD", "JPY", 100)
      end
    end
  end

  test "should raise error for failed exchange rates fetch" do
    # Simulate empty exchange rates cache
    CacheService.stub(:get_all_exchange_rates, nil) do
      assert_raises(StandardError) do
        ConversionService.convert_currency("USD", "EUR", 100)
      end
    end
  end
end
