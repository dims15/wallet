class AdjustAccountTypeAndCustomersIdInAccounts < ActiveRecord::Migration[7.2]
  def change
    change_column :accounts, :account_type, :string, null: false
    change_column_null :accounts, :customers_id, false
  end
end
