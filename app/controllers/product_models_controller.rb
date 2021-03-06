class ProductModelsController < ApplicationController
  before_action :authenticate_user!,
                only: %i[new create destroy edit update]

  def new
    @product_model = ProductModel.new
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :supplier_id, :product_category_id,
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
    @items = @product_model.product_items.group(:warehouse_id).count
  end

  def index
    @product_models = ProductModel.all
  end

  def edit
    @product_model = ProductModel.find(params[:id])
  end

  def update
    @product_model = ProductModel.find(params[:id])
    @product_model.update(params.require(:product_model).permit(:name, :supplier_id, :product_category_id,
                                                                :height, :width, :length, :weight))
    if @product_model.save
      redirect_to @product_model, notice: 'Produto editado com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível editar o produto!'
      render 'edit'
    end
  end

  def activate
    product = ProductModel.find(params[:id])
    product.active!
    redirect_to product
  end

  def disable
    product = ProductModel.find(params[:id])
    product.inactive!
    redirect_to product
  end
end
