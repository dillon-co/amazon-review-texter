class WebhooksController < ApplicationController

  def index
    
  end  


  def call_center_response
    full_data = params[:my_data]
    Webhook.create(fulldata: full_data)
    head 200
  end  
end
