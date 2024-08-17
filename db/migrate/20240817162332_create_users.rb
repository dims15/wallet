class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.primary_key :id
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
