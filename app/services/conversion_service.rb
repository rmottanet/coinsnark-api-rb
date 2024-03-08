require_relative '../helpers/cache_data'


class ConversionService
  def self.convert_currency(from, to, amount)
    # Obter as taxas de câmbio do cache ou da API, conforme necessário
    exchange_rates = CacheService.get_all_exchange_rates

    # Verificar se as taxas de câmbio foram obtidas com sucesso
    raise StandardError, 'Failed to fetch exchange rates.' unless exchange_rates

    # Verificar se as moedas de origem e destino estão presentes nas taxas de câmbio
    raise StandardError, 'Currency codes not found in exchange rates.' unless exchange_rates.key?(from) && exchange_rates.key?(to)

    # Realizar a conversão das moedas
    converted_amount = amount.to_f * exchange_rates[to] / exchange_rates[from]
    cache_updated = Time.now.strftime('%Y-%m-%dT%H:%M:%SZ')
    conversion_info = {
      "cache_updated": cache_updated,
      "from": from,
      "to": to,
      "converted": converted_amount.round(2)
    }

    return conversion_info
  rescue StandardError => e
    raise e
  end
end


