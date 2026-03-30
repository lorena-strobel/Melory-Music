class StockMovement < ApplicationRecord
  belongs_to :item
  delegate :name_item, to: :item, allow_nil:true
  validates :item_id, presence: true
  validates :quantity_stock, presence: true, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      message: "Quantidade deve ser um número inteiro"
    }
end
