module LatestStockPrice
  class FetchService
    def initialize(identifier:)
      @identifier = identifier
    end

    def execute
      client = LatestStockPrice::Client.new
      response = client.price_all(@identifier)
      
      response.to_s
    end
  end
end
