class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name_category
      t.integer :quantity_category

      t.timestamps
    end
  end
end
