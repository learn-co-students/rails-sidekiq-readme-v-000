class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    # redirect processing of the long-running code to the sidekiq worker
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end

end
