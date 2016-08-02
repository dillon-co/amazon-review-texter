class ClientsController < ApplicationController

  def index
    @clients = Client.all
    @todays_clients = Client.where("created_at >= ?", Time.now.beginning_of_day)
  end  
end
