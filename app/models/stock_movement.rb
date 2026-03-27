class StockMovement < ApplicationRecord
  belongs_to :item
  delegate :name_item, to: :item, allow_nil:true
end
