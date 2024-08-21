class AddUniqueFieldUsernameAndAccountNumber < ActiveRecord::Migration[7.2]
  def change
    add_index :accounts, :account_number, unique: true
    add_index :customers, :username, unique: true
  end
end
