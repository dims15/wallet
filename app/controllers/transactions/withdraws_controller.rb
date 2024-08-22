module Transactions
  class WithdrawsController < ApplicationController
    before_action :require_login
    
    include FlashAndRenderConcern
    include IdempotencyConcern

    def new

    end

    def create
      withdraw_service = WithdrawService.new(customer_id: session[:user_id], amount: params[:amount])
      withdraw_service.execute
      
      if withdraw_service.error_message.present?
        store_response_in_redis(deposit_service.error_message)
        set_flash_and_render(withdraw_service.error_message, new_transactions_withdraw_path, :alert)
      else
        success_message = I18n.t('account.balance_deducted', amount: params[:amount])
        store_response_in_redis(success_message)
        set_flash_and_render(success_message, new_transactions_withdraw_path)
      end
    end

    private

    def validate_idempotency_key
      super(new_transactions_withdraw_path)
    end
  end
end
