class CreateStockMovements < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_movements do |t|
      t.datetime :movement_date
      t.string :reason
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
