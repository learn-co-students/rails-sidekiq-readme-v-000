class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:leads].path)
    redirect to customers_path
  end

end
