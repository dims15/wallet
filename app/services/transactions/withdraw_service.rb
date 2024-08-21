module Transactions
  class WithdrawService
    attr_reader :error_message

    def initialize(customer_id:, amount:)
      @customer_id = customer_id
      @amount = amount.to_i
      @error_message = nil
    end

    def execute
      validate_amount

      ActiveRecord::Base.transaction(isolation: :serializable) do
        account = Account.lock.find_by!(customers_id: @customer_id, deleted_at: nil)
        validate_sufficient_balance(account.balance)
        account.update!(balance: (account.balance - @amount))

        Transaction.create!(
          transaction_type: TransactionConstant::Type::DEBIT, 
          amount: @amount,
          source_account_id: account.id,
          description: I18n.t('transaction.log_withdrawal', amount: @amount)
        )
      end
    rescue ActiveRecord::RecordInvalid => e
      @error_message = e.message
    rescue ActiveRecord::RecordNotFound
      @error_message = I18n.t('account.errors.not_found')
    rescue ZeroAmount
      @error_message = I18n.t('transaction.errors.zero_amount')
    rescue InsufficientBalance
      @error_message = I18n.t('transaction.errors.insufficient_balance')
    end

    private

    def validate_amount
      raise ZeroAmount unless @amount > 0
    end

    def validate_sufficient_balance(current_self_balance)
      raise InsufficientBalance if current_self_balance < @amount
    end
  end
end