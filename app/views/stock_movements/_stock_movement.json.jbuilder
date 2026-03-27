json.extract! stock_movement, :id, :movement_date, :reason, :item_id, :created_at, :updated_at
json.url stock_movement_url(stock_movement, format: :json)
