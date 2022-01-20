class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  def new
    @product_category = ProductCategory.new
  end

  def create
    product_category_params = params.require(:product_category).permit(:name)
    @product_category = product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to @product_category, notice: 'Categoria cadastrada com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível cadastrar a nova categoria!'
      render 'new'
    end
  end

  def show
    id = params[:id]
    @product_category = ProductCategory.find(id)
  end

  def index
    @product_category = ProductCategory.all
  end
end
