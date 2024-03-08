require_relative '../helpers/validator'

class ConvertParamsValidator
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    if req.path == '/api/convert' && req.get?
      from = req.params['from']
      to = req.params['to']
      amount = req.params['amount']

      unless from.present? && to.present? && amount.present?
        return [422, { 'Content-Type' => 'application/json' }, [{ error: 'Missing parameters' }.to_json]]
      end

      unless validate_currency_code(from) && validate_currency_code(to) && validate_amount(amount)
        return [422, { 'Content-Type' => 'application/json' }, [{ error: 'Invalid parameters' }.to_json]]
      end
    end

    @app.call(env)
  end
end
