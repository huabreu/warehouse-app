class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    pm = ProductModel.all
    render json: pm.as_json(except: [:created_at, :updated_at]) , status: 200
  end

  def show
    begin
      pm = ProductModel.find(params[:id])
      render json: pm.as_json(except: [:created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404
    end
  end
end