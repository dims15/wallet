module Transactions
  class WithdrawsController < ApplicationController
    include FlashAndRenderConcern

    def new
      # No need to instantiate @transaction
    end

    def create
      withdraw_service = WithdrawService.new(customer_id: session[:user_id], amount: params[:amount])
      withdraw_service.execute
      
      if withdraw_service.error_message.present?
        set_flash_and_render(withdraw_service.error_message, :alert)
      else
        set_flash_and_render(I18n.t('account.balance_deducted', amount: params[:amount]))
      end
    end
  end
end
