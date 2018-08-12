class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:leads].path) #runs file in the background server
    redirect_to customers_path
  end

end
