class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show edit update destroy]

  # GET /brands or /brands.json
  def index
    @q = Brand.ransack(params[:q])
    @brands = @q.result(distinct: true).includes(:items)
  end

  # GET /brands/1 or /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands or /brands.json
  def create
    @brand = Brand.new(brand_params)
    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: "Marca criada com sucesso." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: "Marca atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1 or /brands/1.json
  def destroy
    begin
    if @brand.items.any?
      redirect_to brands_path, alert: "Não é possível excluir uma marca que está associada a um produto"
    else
      @brand.destroy!
      respond_to do |format|
        format.html { redirect_to brands_path, notice: "Marca excluída com sucesso", status: :see_other }
        format.json { head :no_content }
      end
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to brands_path, alert: "Marca não encontrada"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name_brand)
    end
end
