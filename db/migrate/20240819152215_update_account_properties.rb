class UpdateAccountProperties < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :account_number, :string, null: false
    remove_column :accounts, :account_name
    remove_column :accounts, :login_id
    change_column_null :accounts, :balance, false

    add_reference :accounts, :customers, foreign_key: true
  end
end
