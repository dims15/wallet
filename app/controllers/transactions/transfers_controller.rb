module Transactions
  class TransfersController < ApplicationController
    include FlashAndRenderConcern
    
    def new
      # No need to instantiate @transaction
    end

    def create
      transfer_service = TransferService.new(customer_id: session[:user_id], target_account: params[:target_account], amount: params[:amount])
      transfer_service.execute
      
      if transfer_service.error_message.present?
        set_flash_and_render(transfer_service.error_message, :alert)
      else
        set_flash_and_render(I18n.t('transaction.success_transfer', amount: params[:amount], recipient_name: transfer_service.recipient_name))
      end
    end
  end
end
