# test/helpers/validator_test.rb

require_relative '../../app/helpers/validator'
require 'minitest/autorun'

class ValidationTest < Minitest::Test
  def test_validate_currency_code
    assert validate_currency_code("USD")
    assert validate_currency_code("EUR")
    refute validate_currency_code("US")
    assert validate_currency_code("USDD")
    refute validate_currency_code("123")
    refute validate_currency_code("$$$")
  end

  def test_validate_amount
    assert validate_amount(123)
    assert validate_amount("123")
    assert validate_amount(123.45)
    assert validate_amount("123.45")
    refute validate_amount("ABC")
    refute validate_amount("12.34.56")
    refute validate_amount("12,34")
  end
end
