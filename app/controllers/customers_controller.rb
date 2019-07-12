class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

# All you have to do is take the long-running code out of one place def upload, 
# and put it inside of perform:
  def upload
    LeadsWorker.perform_async(params[:leads].path)
      redirect_to customers_path
  end


  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end

end
