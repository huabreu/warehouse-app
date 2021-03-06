class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  def show
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
  end

  def new
    @product_bundle = ProductBundle.new
    @product_models = ProductModel.all
  end

  def create
    product_bundle_params = params.require(:product_bundle).permit(:name,
                                                                   :sku_code, product_model_ids: [])
    @product_bundle = ProductBundle.new(product_bundle_params)
    if @product_bundle.save
      redirect_to @product_bundle, notice: 'Bundle cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível cadastrar o bundle!'
      render 'new'
    end
  end

  def index
    @product_bundles = ProductBundle.all
  end
end
