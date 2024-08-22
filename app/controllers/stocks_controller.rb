class StocksController < ApplicationController
  before_action :require_login
  
  def new
    @stock_data = nil
  end

  def fetch
    identifier = params[:identifier]
    stock_price_service = LatestStockPrice::FetchService.new(identifier: identifier)

    @stock_data = stock_price_service.execute

    if @stock_data.empty?
      flash[:alert] = "No data found for identifier: #{identifier}"
    end

    render :new  # Render the same view
  rescue StandardError => e
    flash[:alert] = "Error fetching stock data: #{e.message}"
    render :new  # Render the same view
  end
end
