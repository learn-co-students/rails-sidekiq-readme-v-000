class LeadsWorker
  require 'csv'
  include SideKiq::Worker

  def perform(leads_file)
    CSV.foreach(params[:leads].path, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end

end
