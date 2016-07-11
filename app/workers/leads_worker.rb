class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(leads_file)
    CSV.foreach(leads_file, headers:true) do |lead|
      Customer.create(email: lead[0], first_name: [1])
    end
  end
end
