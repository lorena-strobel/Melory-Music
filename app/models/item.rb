class Item < ApplicationRecord
  has_many :stock_movements, dependent: :destroy
  belongs_to :category, counter_cache: :quantity_category
  belongs_to :brand, counter_cache: :quantity_brand

  validates :name_item, presence: true, uniqueness: { case_sensitive: false }
  validates :price_item, numericality: { greater_than: 0, message: "Cadastre um número maior que zero" }
  validates :quantity_item, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    message: "Quantidade não pode ser negativa"
  }
  validates :sku, presence: true, uniqueness: true
  validates :price_brl, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity_item, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # campos podem ser pesquisados
  def self.ransackable_attributes(auth_object = nil)
    ["name_item", "quantity_item", "price_brl", "condition", "created_at"]
  end
      # associações que podem ser filtradas
  def self.ransackable_associations(auth_object = nil)
    ["category", "brand"]
  end
end
