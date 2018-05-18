class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
end

# WHAT CAME OVER FROM THE CUSTOMERS_CONTROLLER FILE.
# params[:leads].path vs leads_file        WHY?
# CSV.foreach(params[:leads].path, headers: true) do |lead|
#   Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
# end
