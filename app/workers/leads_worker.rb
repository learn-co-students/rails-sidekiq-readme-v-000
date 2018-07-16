class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  def index
    @customers = Customer.all
  end
  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do
      |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
  def upload
    LeadsWorker.perform_async(params[:lead].path)
    redirect_to customers_path
  end
end
