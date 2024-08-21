module Transactions
  class DepositService
    def initialize(customer_id:, amount:)
      @customer_id = customer_id
      @amount = amount.to_i
    end

    def execute
      raise AmountIsZero unless @amount > 0

      ActiveRecord::Base.transaction(isolation: :read_committed) do
        account = Account.find_by!(customers_id: @customer_id)
        account.update!(balance: (account.balance + @amount))

        transaction_log = Transaction.new(
          transaction_type: TransactionConstant::Type::DEPOSIT, 
          amount: @amount,
          target_account_id: account.id
        )
        transaction_log.save
      end
    end
  end
end