class Account < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.bigint :login_id
      t.string :account_name
      t.integer :account_type
      t.decimal :balance, precision: 16, scale: 2
      t.timestamps :deleted_at

      t.timestamps
    end
  end
end
