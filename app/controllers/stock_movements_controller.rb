class StockMovementsController < ApplicationController
  before_action :set_stock_movement, only: %i[ show edit update]

  # GET /stock_movements or /stock_movements.json
  def index
    @q = StockMovement.ransack(params[:q])
    @stock_movements = @q.result(distinct: true).includes(:item)
  end

  # GET /stock_movements/1 or /stock_movements/1.json
  def show
  end

  # GET /stock_movements/new
  def new
    @stock_movement = StockMovement.new
  end

  # GET /stock_movements/1/edit
  def edit
  end

  # POST /stock_movements or /stock_movements.json
  def create
    @stock_movement = StockMovement.new(stock_movement_params)
    @item = Item.find_by(id: @stock_movement.item_id)

    respond_to do |format|
      if @stock_movement.valid?
        if @item && @item.quantity_item.to_i >= @stock_movement.quantity_stock.to_i
          if @stock_movement.save
            # Mantendo o nome da variável que você pediu
            new_quantity_stock = @item.quantity_item.to_i - @stock_movement.quantity_stock.to_i
            @item.update_column(:quantity_item, new_quantity_stock)

            format.html { redirect_to items_path, notice: "Estoque atualizado" }
            format.json { render :show, status: :created, location: @stock_movement }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        else
          @stock_movement.errors.add(:quantity_stock, "insuficiente para esta saída")
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_movements/1 or /stock_movements/1.json
 def update
    @item = @stock_movement.item
    # o valor que estava salvo no banco antes da atualização chegar
    old_quantity = @stock_movement.quantity_stock.to_i

    respond_to do |format|
      if @stock_movement.update(stock_movement_params)
        new_quantity = @stock_movement.quantity_stock.to_i
        difference = new_quantity - old_quantity
        
        @item.update_column(:quantity_item, @item.quantity_item.to_i - difference)

        format.html { redirect_to @stock_movement, notice: "Estoque editado com sucesso", status: :see_other }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_movement
      @stock_movement = StockMovement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_movement_params
      params.require(:stock_movement).permit(:movement_date, :reason, :quantity_stock, :item_id)
    end
end
