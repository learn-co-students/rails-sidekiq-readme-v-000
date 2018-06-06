class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
end

# That's the basic shape of any worker.
# You'll include Sidekiq::Worker and define a perform instance method that takes in whatever data is required to complete the job. In our case, it will be our leads file.
