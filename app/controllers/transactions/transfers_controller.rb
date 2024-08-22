module Transactions
  class TransfersController < ApplicationController
    before_action :require_login
    
    include FlashAndRenderConcern
    include IdempotencyConcern
    
    def new

    end

    def create
      transfer_service = TransferService.new(customer_id: session[:user_id], target_account: params[:target_account], amount: params[:amount])
      transfer_service.execute
      
      if transfer_service.error_message.present?
        store_response_in_redis(transfer_service.error_message)
        set_flash_and_render(transfer_service.error_message, new_transactions_transfer_path, :alert)
      else
        success_message = I18n.t('transaction.success_transfer', amount: params[:amount], recipient_name: transfer_service.recipient_name)
        store_response_in_redis(success_message)
        set_flash_and_render(success_message, new_transactions_transfer_path)
      end
    end

    private

    def validate_idempotency_key
      super(new_transactions_transfer_path)
    end
  end
end
