class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end
  
  def new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address, :city, :state, :zip_code,
                                                          :description, :useful_area, :total_area) 
    warehouse = Warehouse.new(warehouse_params)
    warehouse.save()
    # flash[:notice] = 'Galpão cadastrado com sucesso!'
    redirect_to warehouse_path(warehouse.id), notice: 'Galpão cadastrado com sucesso!'
  end
end