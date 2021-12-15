class ProductModelsController < ApplicationController
  def new
    @product_model = ProductModel.new
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :sku_code, :supplier_id,
                                                                 :height, :width, :length, :weight)
    @product_model = product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to product_model_path(@product_model.id), notice: 'Produto cadastrado com sucesso!'
    end
  end

  def show
    id = params[:id]
    @product_model = ProductModel.find(id)
  end
end