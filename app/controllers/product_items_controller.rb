class ProductItemsController < ApplicationController
  def new_entry
    @warehouses = Warehouse.all 
    @product_models = ProductModel.all
  end

  def process_entry
    product_entry = ProductEntry.new(quantity: params[:quantity], product_model_id: params[:product_model_id],
                     warehouse_id: params[:warehouse_id])
    if product_entry.process()
      redirect_to warehouse_path(product_entry.warehouse_id), notice: 'Entrada do novo lote realizada com sucesso!'
    else
      flash[:alert] = 'Erro! Não foi possível completar a solicitação'
      redirect_back fallback_location: 'new_entry'
    end
  end
end
