class AddCustomerTable < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :password
      t.string :name
      t.datetime :birth_date
      t.string :phone
      t.string :address
      t.integer :customer_type
      t.json :additional_info
      t.datetime :last_login
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
