class UpdateCustomerProperties < ActiveRecord::Migration[7.2]
  def change
    change_column_null :customers, :username, false
    change_column_null :customers, :password, false
    change_column_null :customers, :name, false
    change_column_null :customers, :birth_date, false
    change_column_null :customers, :phone, false
    change_column_null :customers, :address, false
    change_column_null :customers, :customer_type, false
  end
end
