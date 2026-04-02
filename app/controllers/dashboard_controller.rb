class DashboardController < ApplicationController
  def index
    @total_items = Item.count
    @total_brands = Brand.count
    @total_categories = Category.count
    @total_stock_movements = StockMovement.count
    # cálculo do valor total em brl para exibir 
    @total_brl = Item.all.sum { |item| (item.quantity_item || 0) * (item.price_brl || 0) }

    @currency = params[:currency] || 'BRL'
    if @currency != 'BRL'
      response = HTTParty.get("https://economia.awesomeapi.com.br/json/last/#{@currency}-BRL")
      if response.success?
        @rate = response.parsed_response["#{@currency}BRL"]["bid"].to_f
        @total_exibir = (@total_brl / @rate).round(2)  
      end
    else
      @total_exibir = @total_brl
    end
  end

  def total_inventory
    # cálcula valor totoal do estoque 
    total_brl = Item.all.sum { |item| (item.quantity_item || 0) * (item.price_brl || 0)}

    currency = params[:currency] || 'BRL' # pramentro opcional
    
    # entrega o resultado em reais se o usuário não fornecer um parametro
    if currency == 'BRL'
      render json: {
        total_value: total_brl,
        currency: 'BRL'
      }
    # se o usuário digitou um parametro para o cálculo da cotação
    else
      response = HTTParty.get("https://economia.awesomeapi.com.br/json/last/#{currency}-BRL")

      if response.success?
        rate = response.parsed_response["#{currency}BRL"]["bid"].to_f
        total_converted = (total_brl / rate).round(2)

        render json: {
          total_value: total_converted,
          currency: currency,
          exchange_rate:  rate  # valor de acordo com a cotação usada
        }
      else
        render json: {
          error: "Tipo de moeda não suportada"
        } , status: :bad_request
      end
    end
  end
end
