# Sidekiq relies on a Worker to define and process a job; added in app/workers 
class LeadsWorker
 require 'csv' # a complete interface to CSV files and data

 include Sidekiq::Worker

 def perform(leads_file)
 	# long-running code
 	CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
 end
end
