require 'active_support/cache/memory_store'
require_relative '../../app/integrations/bcb_quotes.rb'
require_relative '../../app/helpers/cache_data.rb'

Rails.application.config.after_initialize do
	Rails.cache.logger = Logger.new(STDOUT)
	Rails.cache.logger.level = Logger::INFO
	
	begin
		# Recupera os dados do cache
		Rails.logger.info "Iniciando recuperação de dados do cache"
		exchange_rates_from_cache = CacheService.get_all_exchange_rates
		
		# Se os dados estiverem em cache, registra no log e retorna
		if !exchange_rates_from_cache.empty?
		Rails.logger.info "Taxas de câmbio recuperadas do cache: #{exchange_rates_from_cache}"
		return
		end
		
		# Se os dados não estiverem em cache, obtém as taxas de câmbio do BCB e salva em cache
		exchange_rates = BCBQuotes.get_exchange_rates
		CacheService.save_exchange_rates(exchange_rates)
		rescue => e
		Rails.logger.error "Erro ao inicializar o cache: #{e.message}"
	end
end
