module Transactions
  class DepositsController < ApplicationController
    include FlashAndRenderConcern

    def new
      # No need to instantiate @transaction
    end

    def create
      deposit_service = DepositService.new(customer_id: session[:user_id], amount: params[:amount])
      deposit_service.execute
      
      if deposit_service.error_message.present?
        set_flash_and_render(deposit_service.error_message, :alert)
      else
        set_flash_and_render(I18n.t('account.balance_added', amount: params[:amount]))
      end
    end
  end
end