class StockMovementsController < ApplicationController
  before_action :set_stock_movement, only: %i[ show edit update]

  # GET /stock_movements or /stock_movements.json
  def index
    @stock_movements = StockMovement.all
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
      # verifica se tem estoque suficiente
      if @item && @item.quantity_item.to_i >= params[:quantity_stock].to_i
        if @stock_movement.save
          # atualiza estoque de item ao realizar a movimentação
          new_quantity_stock = @item.quantity_item.to_i - params[:quantity_stock].to_i
          @item.update(quantity_item: new_quantity_stock)
          
          format.html { redirect_to @stock_movement, notice: "Stock movement was successfully created." }
          format.json { render :show, status: :created, location: @stock_movement }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
        end
      else
        # se não tiver estoque 
        @stock_movement.errors.add(:base, "Estoque insuficiente ou item não encontrado")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_movements/1 or /stock_movements/1.json
  def update
    respond_to do |format|
      if @stock_movement.update(stock_movement_params)
        format.html { redirect_to @stock_movement, notice: "Stock movement was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
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
      params.require(:stock_movement).permit(:movement_date, :reason, :item_id)
    end
end
