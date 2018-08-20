class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:leads].path)
    #Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
     redirect_to customers_path
  end

end
