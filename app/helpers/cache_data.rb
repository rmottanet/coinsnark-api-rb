require 'rails'
require 'active_support/cache/memory_store'


class CacheService
  RATES_CACHE = 'rates_cache'

  def self.save_exchange_rates(exchange_rates)
    Rails.logger.info "Função de cache acionada"
    Rails.logger.info "Dados recebidos:"
    Rails.logger.info exchange_rates

    begin
      # Armazenar o hash inteiro de taxas de câmbio sob a chave 'rates_cache'
      Rails.cache.write(RATES_CACHE, exchange_rates)
      Rails.logger.info "Taxas de câmbio salvas no cache com sucesso!"

      # Recuperar os dados do cache após salvá-los
      exchange_rates_from_cache = get_all_exchange_rates
      Rails.logger.info "Dados em cache recuperados após salvamento: #{exchange_rates_from_cache}"
    rescue => e
      Rails.logger.info "Erro ao salvar as taxas de câmbio no cache: #{e.message}"
    end
  end

  def self.get_all_exchange_rates
    begin
      # Recuperar os dados do cache e retorná-los
      exchange_rates = Rails.cache.read(RATES_CACHE) || {}
      Rails.logger.info "Dados em cache recuperados: #{exchange_rates}"
      return exchange_rates
    rescue => e
      puts "Erro ao recuperar cache: #{e.message}"
      return {}
    end
  end
end

