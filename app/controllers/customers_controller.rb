class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    # this loop has been moved to the leads_worker file so it can run in the background
    # CSV.foreach(params[:leads].path, headers: true) do |lead|
    #   Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    # end
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end
end
