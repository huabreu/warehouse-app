class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    pm = ProductModel.all
    render json: pm.as_json(except: [:created_at, :updated_at], methods: [:dimensions]) , status: 200
  end

  def show
    begin
      pm = ProductModel.find(params[:id])
      render json: pm.as_json(except: [:created_at, :updated_at, :supplier_id, :product_category_id], 
                              include: { supplier: { except: [:created_at, :updated_at]}, 
                              product_category: { except: [:created_at, :updated_at]} } ), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404
    end
  end
end