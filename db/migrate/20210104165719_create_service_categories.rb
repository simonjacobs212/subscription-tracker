class CreateServiceCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :service_categories do |t|
      t.integer :category_id
      t.integer :service_id
      t.timestamps
    end
  end
end
