class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all 
    @supplier = Supplier.all
  end
end