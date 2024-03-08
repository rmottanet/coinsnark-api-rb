module Fetcher
  require 'net/http'
  require 'json'

  def self.fetch_data(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error "Erro ao obter dados: #{e.message}"
    nil
  end
end
