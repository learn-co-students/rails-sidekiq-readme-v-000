class LeadsWorker
  require 'CSV'
  include Sidekiq::Worker


  def perform(lead_file)
    CSV.foreach(lead_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end

end
