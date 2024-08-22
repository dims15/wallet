module Transactions
  class CheckBalanceController < ApplicationController
    before_action :require_login
    
    def new
      check_balance_service = CheckBalanceService.new(customer_id: session[:user_id])
      check_balance_service.execute
      
      if check_balance_service.error_message.present?
        @message = 'You dont have associated account'
      else
        @message = I18n.t('transaction.your_current_balance', balance: check_balance_service.balance)
      end
    end
  end
end
