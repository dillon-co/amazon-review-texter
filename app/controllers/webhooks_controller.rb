class WebhooksController < ApplicationController

  def index
    @webhooks = Webhook.all
  end  


  def call_center_response
    # full_data = params[:my_data]
    # Webhook.create(fulldata: full_data)
    head 200
  end  
end
