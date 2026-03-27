class CreateBrands < ActiveRecord::Migration[7.2]
  def change
    create_table :brands do |t|
      t.string :name_brand
      t.integer :quantity_brand

      t.timestamps
    end
  end
end
