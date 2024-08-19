class UpdateTransactionsProperties < ActiveRecord::Migration[7.2]
  def change
    remove_column :transactions, :source_account_id
    remove_column :transactions, :target_account_id

    add_reference :transactions, :source_account, foreign_key: { to_table: :accounts }
    add_reference :transactions, :target_account, foreign_key: { to_table: :accounts }, null: true
  end
end
