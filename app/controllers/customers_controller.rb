class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    # NOTE : Replaces the CSV upload loop
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end

end
