# Sidekiq relies on a Worker to define and process a job. Let's add an app/workers directory and create our first worker
# That's the basic shape of any worker. You'll include Sidekiq::Worker and define a perform instance method that takes in whatever data is required to complete the job. In our case, it will be our leads file.
class LeadsWorker

 require 'csv'
 include Sidekiq::Worker

 def perform(leads_file)
     CSV.foreach(params[:leads].path, headers: true) do |lead|
       Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
   end
end
end
