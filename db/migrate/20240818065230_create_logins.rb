class CreateLogins < ActiveRecord::Migration[7.2]
  def change
    create_table :logins do |t|
      t.string :username
      t.string :password
      t.timestamps :last_login
      t.timestamps :deleted_at

      t.timestamps
    end
  end
end
