class SuppliersController < ApplicationController
  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:trade_name, :company, :address, :cnpj, :email, :phone) 
    @supplier = Supplier.new(supplier_params)
    if @supplier.save()
      redirect_to supplier_path(@supplier.id), notice: 'Fornecedor cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Erro! Não foi possível salvar o fornecedor!'
      render 'new'
    end

    def show
      id = params[:id]
      @supplier = Supplier.find(id)
    end

    def index
      puts 'ola'
    end
  end
end