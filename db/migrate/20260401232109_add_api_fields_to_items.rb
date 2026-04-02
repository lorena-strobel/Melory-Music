class AddApiFieldsToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :sku, :string
    add_column :items, :price_brl, :decimal
  end
end
