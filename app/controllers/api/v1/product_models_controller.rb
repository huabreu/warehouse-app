class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    pm = ProductModel.all
    render json: pm.as_json(except: %i[created_at updated_at], methods: [:dimensions]),
           status: :ok
  end

  def show
    pm = ProductModel.find(params[:id])
    render json: pm.as_json(except: %i[created_at updated_at supplier_id product_category_id],
                            include: { supplier: { except: %i[created_at updated_at] },
                                       product_category: { except: %i[created_at
                                                                      updated_at] } }), status: :ok
  end

  def create
    product_model_params = params.permit(:name, :supplier_id,
                                         :product_category_id, :height, :width, :length, :weight)
    pm = ProductModel.new(product_model_params)
    if pm.save
      render json: pm.as_json(except: %i[created_at updated_at]),
             status: :created
    else
      error_422(pm)
    end
  end
end
