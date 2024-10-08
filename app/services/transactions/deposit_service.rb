module Transactions
  class DepositService
    attr_reader :error_message

    def initialize(customer_id:, amount:)
      @customer_id = customer_id
      @amount = amount.to_i
      @error_message = nil
    end

    def execute
      raise ZeroAmount unless @amount > 0

      ActiveRecord::Base.transaction(isolation: :serializable) do
        account = Account.lock.find_by!(customers_id: @customer_id, deleted_at: nil)
        account.update!(balance: (account.balance + @amount))

        Transaction.create!(
          transaction_type: TransactionConstant::Type::CREDIT, 
          amount: @amount,
          target_account_id: account.id,
          description: I18n.t('transaction.log_deposit', amount: @amount)
        )
      end
    rescue ActiveRecord::RecordInvalid => e
      @error_message = e.message
    rescue ActiveRecord::RecordNotFound
      @error_message = I18n.t('account.errors.not_found')
    rescue ZeroAmount
      @error_message = I18n.t('transaction.errors.zero_amount')
    end
  end
end