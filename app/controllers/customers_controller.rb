class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    #work done in workers/leads_worker.rb 
    redirect_to customers_path
  end

end
