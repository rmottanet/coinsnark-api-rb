# coinsnark-rb/config/application.rb
require_relative "boot"
require "rails/all"
require 'active_support/cache/memory_store'
require_relative '../app/middleware/convert_params_validator'
#require_relative '../app/integrations/bcb_quotes.rb'
#require_relative '../app/helpers/cache_data.rb'
Bundler.require(*Rails.groups)

module Coinsnark
  class Application < Rails::Application
    config.load_defaults 7.1

    Dotenv::Railtie.load
    
	# Require the middleware
    config.middleware.use ConvertParamsValidator

  end
end
