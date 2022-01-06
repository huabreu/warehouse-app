class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
    @items = @warehouse.product_items.group(:product_model_id).count
    @product_models = ProductModel.all
  end
  
  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address, :city, :state, :zip_code,
                                                         :description, :useful_area, :total_area) 
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
    # flash[:notice] = 'Galpão cadastrado com sucesso!'
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível salvar o galpão!'
      render 'new'
    end
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    @warehouse.update(params.require(:warehouse).permit(:name, :code, :address, :city, :state, :zip_code,
    :description, :useful_area, :total_area))
    if @warehouse.save()
      redirect_to @warehouse, notice: 'Galpão editado com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível editar o galpão!'
      render 'edit'
    end
  end

  def product_entry
    quantity = params[:quantity].to_i
    warehouse_id = params[:id]
    product_model_id = params[:product_model_id]

    warehouse = Warehouse.find(warehouse_id)
    product_model = ProductModel.find(product_model_id)

    quantity.times do
      ProductItem.create(warehouse: warehouse, product_model: product_model)
    end
    
    redirect_to warehouse
  end
end