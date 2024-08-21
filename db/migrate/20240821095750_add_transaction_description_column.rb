class AddTransactionDescriptionColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :description, :string, null: false
  end
end
