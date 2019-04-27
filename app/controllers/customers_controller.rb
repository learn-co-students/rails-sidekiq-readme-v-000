class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWroker.perform_asyn(params[:leads].path)
    redirect_to customers_path
  end

end
