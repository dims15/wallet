class AdjustTransactionTypeAndAmountInTransaction < ActiveRecord::Migration[7.2]
  def change
    change_column_null :transactions, :transaction_type, false
    change_column_null :transactions, :amount, false
  end
end
