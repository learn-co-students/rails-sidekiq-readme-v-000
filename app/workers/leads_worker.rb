class LeadsWorker
  include Sidekiq::Worker
  require 'csv'
  def perform(leads_file)
    CSV.foreach(params[:file].path, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
end  