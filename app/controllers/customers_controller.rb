class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload

    LeadsWorker.perform_async(params[:leads].path)
    # The line above replaces the commented code below to run in background
    # CSV.foreach(params[:leads].path, headers: true) do |lead|
    #   Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    # end
    redirect_to customers_path
  end

end
