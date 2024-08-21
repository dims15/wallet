module TransactionService
  class Withdrawal
    def initialize(account_number, amount)
      @account_number = account_number
      @amount = amount
    end

    def execute
      ActiveRecord::Base.transaction(isolation: :serializable) do
        retrieve_account
        perform_withdrawal
        record_transaction
      end
    rescue => e
      raise ActiveRecord::Rollback, "Transaction failed: #{e.message}"
    end
  
    private

    def retrieve_account
      
    end
  
    def perform_withdrawal
      raise "Insufficient funds" if @account.balance < @amount
  
      @account.balance -= @amount
      @account.save!
    end
  
    def record_transaction
      TransactionHistory.create!(
        account: @account,
        transaction_type: TransactionTypes::TransactionType::WITHDRAWAL,
        amount: @amount,
        balance_after: @account.balance
      )
    end
  end
end