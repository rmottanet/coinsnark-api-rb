require_relative '../helpers/currency_data'


class CurrencyService
  RATES_CACHE = 'rates_cache'.freeze

  def self.get_currency_names_from_cache(cache)
    begin
      cached_contents = cache.read(RATES_CACHE)

      if cached_contents.nil?
        return {}
      else
        currency_names = {}

        cached_contents.each_key do |currency_code|
          currency_name = CURRENCY_NAMES[currency_code.to_sym] || "Unknown"
          currency_names[currency_code] = currency_name
        end

        return currency_names
      end
    rescue StandardError => e
      raise "Error retrieving currency names from cache: #{e.message}"
    end
  end
end

