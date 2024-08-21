module Transactions
  class DepositsController < ApplicationController
    def new
      # No need to instantiate @transaction
    end

    def create
      DepositService.new(customer_id: session[:user_id], amount: params[:amount]).execute
      
      set_flash_and_render('Amount added to your account')
    rescue ActiveRecord::RecordInvalid => e
      set_flash_and_render(e.message, :alert)
    rescue ActiveRecord::RecordNotFound
      set_flash_and_render('Account not found', :alert)
    rescue AmountIsZero
      set_flash_and_render("Amount can't be empty or 0", :alert)
    end

    private

    def set_flash_and_render(message, flash_type = :notice, template = :new)
      flash.now[flash_type] = message
      render template
    end
  end
end