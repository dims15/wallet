module Transactions
  class CheckBalanceService
    attr_reader :error_message, :balance

    def initialize(customer_id:)
      @customer_id = customer_id
      @error_message = nil
      @balance = nil
    end

    def execute
      account = Account.find_by!(customers_id: @customer_id)
      @balance = account.balance
    rescue ActiveRecord::RecordNotFound
      @error_message = I18n.t('account.not_found')
    end
  end
end