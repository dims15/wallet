# lib/latest_stock_price/client.rb
require 'uri'
require 'net/http'
require 'json'

module LatestStockPrice
  class Client
    RAPIDAPI_HOST = ENV['RAPIDAPI_HOST'].freeze

    def initialize
      byebug
      @base_url = "https://#{RAPIDAPI_HOST}/"
    end

    def price_all(identifier)
      url = URI("#{@base_url}any?Identifier=#{identifier}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['x-rapidapi-key'] = ENV['RAPIDAPI_KEY']
      request['x-rapidapi-host'] = RAPIDAPI_HOST

      response = http.request(request)
      JSON.parse(response.read_body)
    rescue StandardError => e
      { error: e.message }
    end
  end
end
