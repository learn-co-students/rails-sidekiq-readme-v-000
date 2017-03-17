class LeadsWorker
  require 'csv'
  include Sidekiq::Worker 

  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end

  def self.clear_leads
    Customer.destroy_all
  end

end
