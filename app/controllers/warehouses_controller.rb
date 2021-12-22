class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
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
end