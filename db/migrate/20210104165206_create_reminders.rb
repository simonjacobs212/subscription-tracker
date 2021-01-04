class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.integer :days_notice
      t.boolean :active
      t.timestamps
    end
  end
end
