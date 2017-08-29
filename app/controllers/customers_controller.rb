class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end
end
