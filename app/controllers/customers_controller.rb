class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:lead].path)
    redirect_to customers_path
  end

end
