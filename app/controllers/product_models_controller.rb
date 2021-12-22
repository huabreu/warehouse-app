class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  
  def new
    @product_model = ProductModel.new
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :sku_code, :supplier_id,
                                                                 :height, :width, :length, :weight)
    @product_model = product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Produto cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível cadastrar o produto!'
      render 'new'
    end
  end

  def show
    id = params[:id]
    @product_model = ProductModel.find(id)
  end

  def index
    @product_models = ProductModel.all
  end
end