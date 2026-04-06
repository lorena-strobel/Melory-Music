class Item < ApplicationRecord
  has_many :stock_movements, dependent: :destroy
  belongs_to :category, counter_cache: :quantity_category
  belongs_to :brand, counter_cache: :quantity_brand

  validates :name_item, presence: { message: "Nome do item não pode estar vazio"}, uniqueness: { case_sensitive: false }
  validates :price_brl, numericality: { greater_than: 0, message: "Preço deve ser maior do que zero" }
  validates :quantity_item, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    message: "Quantidade não pode ser negativa"
  }
  validates :sku, presence: { message: "Código SKU é obrigatório"}, uniqueness: true

  # campos podem ser pesquisados
  def self.ransackable_attributes(auth_object = nil)
    ["name_item", "quantity_item", "price_brl", "condition", "created_at"]
  end
      # associações que podem ser filtradas
  def self.ransackable_associations(auth_object = nil)
    ["category", "brand"]
  end
end
