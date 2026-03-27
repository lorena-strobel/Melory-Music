json.extract! item, :id, :name_item, :quantity_item, :price_item, :condition, :category_id, :brand_id, :created_at, :updated_at
json.url item_url(item, format: :json)
