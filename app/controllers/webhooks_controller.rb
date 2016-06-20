class WebhooksController < ApplicationController

  def index
    @webhooks = Webhook.all
  end  


  def call_center_response
    user = user.find_or_create_by(name: params[:first_name], phone_number: params[:phone_number].to_s)
    product = user.products.find_by(amazon_id: params[:product_id])
    product.messages.create(user_name: user.first_name, user_number: user.phone_number, product_name: product.name, review_redirect_url: review_redirect_url(product_id))
    # Webhook.create(fulldata: full_data)
    head 200
  end  
end
