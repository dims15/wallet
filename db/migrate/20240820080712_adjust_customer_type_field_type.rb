class AdjustCustomerTypeFieldType < ActiveRecord::Migration[7.2]
  def change
    change_column :customers, :customer_type, :string, null: false
  end
end
