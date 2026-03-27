class AddQuantityStockToStockMovements < ActiveRecord::Migration[7.2]
  def change
    add_column :stock_movements, :quantity_stock, :integer
  end
end
