class LeadsWorker
  require 'csv'
  include Sidekiq::Worker 

  def perform(csv_file)
    CSV.foreach(csv_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
end