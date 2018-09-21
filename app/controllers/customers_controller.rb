class CustomersController < ApplicationController
  require 'csv'
  require "redis"

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end
  
end
