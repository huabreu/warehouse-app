class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :error_400
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActiveRecord::StatementInvalid, with: :error_412
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :error_500
  
  private

  def error_400
    render json: {"error": "Bad Request"}, status: 500
  end

  def error_404
    render json: {"error": "Objeto não encontrado"}, status: 404
  end

  def error_412
    render json: {"error": "Parâmetro inválido"}, status: 412
  end

  def error_422(object)
    render json: object.errors.full_messages, status: 422
  end

  def error_500
    render json: {"error": "Erro ao estabelecer uma conexão com o banco de dados"}, status: 500
  end
end