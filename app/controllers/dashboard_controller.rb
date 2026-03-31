class DashboardController < ApplicationController
  def index
      @total_items = Item.count
      @total_brands = Brand.count
      @total_categories = Category.count
      @total_stock_movements = StockMovement.count
  end
end
