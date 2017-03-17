class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end

  def clear_leads
    LeadsWorker.clear_leads
    redirect_to customers_path
  end
end
