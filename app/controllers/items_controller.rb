class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update]

  # GET /items or /items.json
  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).includes(:category, :brand)

    @currency = params[:currency] || "BRL"
    @total_brl = @items.sum { |item| (item.quantity_item || 0) * (item.price_brl || 0) }

    if @currency != "BRL"
      response = HTTParty.get("https://economia.awesomeapi.com.br/json/last/#{@currency}-BRL")
      if response.success?
        @rate = response.parsed_response["#{@currency}BRL"]["bid"].to_f
        @total_exibir = (@total_brl / @rate).round(2)
      else
        @rate = 1.0
        @total_exibir = @total_brl
      end
    else
      @rate = 1.0
      @total_exibir = @total_brl
    end
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create # lógica de add_item
    @item = Item.find_by("lower(name_item) = ?", item_params[:name_item].downcase) # procura item existente

    if @item # se item existir
      new_quantity = @item.quantity_item.to_i + item_params[:quantity_item].to_i # se existir quantidade é adicionada a existente

      respond_to do |format|
        if @item.update(quantity_item: new_quantity, price_brl: item_params[:price_brl])
          format.html { redirect_to @item, notice: "Item atualizado com sucesso" }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    else
      # Se o item não existir no banco
      @item = Item.new(item_params)

      respond_to do |format|
        if @item.save
          format.html { redirect_to @item, notice: "Item criado com sucesso" }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item atualizado com sucesso", status: :see_other }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    begin
      @item = Item.find(params[:id])
      @item.destroy!
      respond_to do |format|
          format.html { redirect_to items_path, notice: "Item excluído com sucesso.", status: :see_other }
          format.json { head :no_content }
    end
    rescue ActiveRecord::RecordNotFound # se não existir lança erro de item não encontrado
      respond_to do |format|
        format.html { redirect_to items_path, notice: "Item não encontrado." }
        format.json { render json: { error: "Item não encontrado" }, status: :not_found }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name_item, :quantity_item, :sku, :price_brl, :condition, :category_id, :brand_id)
    end

    def total_value
      @total = Item.all.sum { |i| i.price_brl.to_f * i.quantity_item.to_i }
      # formata como moeda
      ActionController::Base.helpers.number_to_currency(@total, unit: "R$ ", separator: ",", delimiter: ".")
    end
end
