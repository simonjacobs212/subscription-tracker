class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :service_id
      t.string :email
      t.integer :user_id
      t.integer :duration
      t.float :cost_per_duration
      t.date :renewal_date
      t.timestamps
    end
  end
end
