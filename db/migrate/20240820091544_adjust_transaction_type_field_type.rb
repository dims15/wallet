class AdjustTransactionTypeFieldType < ActiveRecord::Migration[7.2]
  def change
    change_column :transactions, :transaction_type, :string, null: false
  end
end
