class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.decimal :balance, precision: 16, scale: 2
      t.bigint :source_account_id
      t.bigint :target_account_id

      t.timestamps
    end
  end
end
