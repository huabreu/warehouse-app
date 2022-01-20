class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses.as_json(except: %i[created_at updated_at]),
           status: :ok
  end

  def show
    warehouse = Warehouse.find(params[:id])
    render json: warehouse.as_json(except: %i[created_at updated_at]),
           status: :ok
  end

  def create
    warehouse_params = params.permit(:name, :code, :description, :zip_code,
                                     :address, :city, :state, :total_area, :useful_area)
    w = Warehouse.new(warehouse_params)
    if w.save
      render json: w, status: :created
    else
      error_422(w)
    end
  end
end
