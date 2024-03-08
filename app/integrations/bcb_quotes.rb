require 'json'
require 'net/http'

class BCBQuotes
  API_URL = "https://www.bcb.gov.br/api/servico/sitebcb/indicadorCambio"

  def self.get_exchange_rates
    begin

      response = Net::HTTP.get_response(URI(API_URL))

      unless response.is_a?(Net::HTTPSuccess)
        raise StandardError, "Erro ao obter os dados da API: #{response.message}"
      end

      Rails.logger.info "Exchange rates data retrieved successfully from API."

      bcb_rates_data = JSON.parse(response.body)
      currency_rates = {}

      bcb_rates_data["conteudo"].each do |item|
        currency_name = item["moeda"]
        currency_buy_value = item["valorCompra"]

        currency_rates[currency_name] = currency_buy_value
      end

      brl_to_usd = currency_rates["Dólar"]

      eur_to_brl = currency_rates["Euro"]
      eur_to_usd = 1 / (eur_to_brl / brl_to_usd).round(4)
      
      exchange_rates = { "USD" => 1, "BRL" => brl_to_usd, "EUR" => eur_to_usd }
		puts exchange_rates
      return exchange_rates
    rescue StandardError => e
	  Rails.logger.error "Error fetching exchange rates: #{e.message}"
      raise e
    end
  end
end
