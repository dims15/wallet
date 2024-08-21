module Transactions
  class TransferService
    attr_reader :error_message, :recipient_name

    def initialize(customer_id:, target_account:, amount:)
      @customer_id = customer_id
      @target_account = target_account
      @amount_transferred = amount.to_i
      @error_message = nil
      @recipient_name = nil
    end

    def execute
      validate_amount

      ActiveRecord::Base.transaction(isolation: :serializable) do
        source_account = Account.lock.find_by!(customers_id: @customer_id, deleted_at: nil)

        validate_equal_source_and_target(source_account.account_number)

        target_account = Account.lock.find_by!(account_number: @target_account, deleted_at: nil)

        @recipient_name = target_account.customer.name

        validate_sufficient_balance(source_account.balance)

        source_account.update!(balance: (source_account.balance - @amount_transferred))
        target_account.update!(balance: (target_account.balance + @amount_transferred))

        log_transaction(TransactionConstant::Type::DEBIT, source_account.id, target_account.id, 'log_debit_transfer')
        log_transaction(TransactionConstant::Type::CREDIT, source_account.id, target_account.id, 'log_credit_transfer')
      end
    rescue ActiveRecord::RecordInvalid => e
      @error_message = e.message
    rescue ActiveRecord::RecordNotFound
      @error_message = I18n.t('account.errors.not_found')
    rescue ZeroAmount
      @error_message = I18n.t('transaction.errors.zero_amount')
    rescue SameSourceAndTargetAccount
      @error_message = I18n.t('transaction.errors.equal_source_and_target_account')
    rescue InsufficientBalance
      @error_message = I18n.t('transaction.errors.insufficient_balance')
    end

    private

    def validate_equal_source_and_target(source_account_number)
      raise SameSourceAndTargetAccount if @target_account.eql?(source_account_number)
    end

    def validate_sufficient_balance(current_self_balance)
      raise InsufficientBalance if current_self_balance < @amount_transferred
    end

    def validate_amount
      raise ZeroAmount unless @amount_transferred > 0
    end

    def log_transaction(transaction_type, source_account_id, target_account_id, translation_key)
      Transaction.create!(
        transaction_type: transaction_type,
        amount: @amount_transferred,
        source_account_id: source_account_id,
        target_account_id: target_account_id,
        description: I18n.t("transaction.#{translation_key}", amount: @amount_transferred)
      )
    end
  end
end