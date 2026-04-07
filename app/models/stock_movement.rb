class StockMovement < ApplicationRecord
  belongs_to :item
  delegate :name_item, to: :item, allow_nil: true
  validates :item_id, presence: { message: "Item deve ser selecionado" }
  validates :movement_date, presence: { message: "Data e horário devem ser preenchidos" }
  validates :reason, presence: { message: "Motivo deve ser preenchido" }
  validates :quantity_stock, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      message: "Quantidade deve ser um número inteiro"
  }
  def self.ransackable_attributes(auth_object = nil)
    [ "movement_date", "quantity_stock", "created_at", "item_id", "reason" ]
  end
  def self.ransackable_associations(auth_object = nil)
    [ "item" ]
  end
end
