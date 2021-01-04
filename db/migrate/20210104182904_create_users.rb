class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :app_username
      t.string :app_password
      t.timestamps
    end
  end
end
