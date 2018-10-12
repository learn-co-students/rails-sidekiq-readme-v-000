class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

 LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end

end
