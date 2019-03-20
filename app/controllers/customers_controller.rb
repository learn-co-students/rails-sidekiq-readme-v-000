class CustomersController < ApplicationController
	require 'leads_worker'
	
	def index
    @customers = Customer.all
  end

	def upload
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end
end
