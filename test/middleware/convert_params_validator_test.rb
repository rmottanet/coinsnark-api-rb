# test/middleware/convert_params_validator_test.rb
require 'test_helper'
require_relative '../../app/middleware/convert_params_validator'

class ConvertParamsValidatorTest < ActiveSupport::TestCase
  def app
    ->(env) { [200, env, ''] }
  end

  test 'it returns 422 with error message for missing parameters' do
    middleware = ConvertParamsValidator.new(app)

    status, headers, body = middleware.call({
      'REQUEST_METHOD' => 'GET',
      'PATH_INFO' => '/api/convert',
      'QUERY_STRING' => 'from=USD&to=EUR' # Missing 'amount'
    })

    assert_equal 422, status
    assert_equal 'application/json', headers['Content-Type']
    assert_equal [{ error: 'Missing parameters' }.to_json], body
  end

  test 'it returns 422 with error message for invalid parameters' do
    middleware = ConvertParamsValidator.new(app)

    status, headers, body = middleware.call({
      'REQUEST_METHOD' => 'GET',
      'PATH_INFO' => '/api/convert',
      'QUERY_STRING' => 'from=USD&to=INVALID&amount=100'
    })

    assert_equal 422, status
    assert_equal 'application/json', headers['Content-Type']
    assert_equal [{ error: 'Invalid parameters' }.to_json], body
  end

  test 'it calls the app if parameters are valid' do
    middleware = ConvertParamsValidator.new(app)

    status, headers, body = middleware.call({
      'REQUEST_METHOD' => 'GET',
      'PATH_INFO' => '/api/convert',
      'QUERY_STRING' => 'from=USD&to=EUR&amount=100'
    })

    assert_equal 200, status
  end
end
