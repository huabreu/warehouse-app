class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render json: suppliers.as_json(except: [:created_at, :updated_at]) , status: 200
  end

  def show
    s = Supplier.find(params[:id])
    render json: s.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def create
    supplier_params = params.permit(:trade_name, :company_name, :cnpj, :address, :email, :phone)
    s = Supplier.new(supplier_params)
    if s.save
      render json: s.as_json(except: [:created_at, :updated_at]), status: 201
    else
      render json: s.errors.full_messages, status: 422
    end
  end
end