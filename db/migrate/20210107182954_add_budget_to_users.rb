class AddBudgetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :budget, :float
  end
end
