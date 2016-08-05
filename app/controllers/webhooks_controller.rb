class WebhooksController < ApplicationController

  def index
    @webhooks = Webhook.all
  end  


  def call_center_response

    first_name, phone_number, product_id, product_name = params['first_name'], params['phone_number'].to_s, params['product_id'], params['product_name']
    Rails.logger.warn("#{"\n"*10}#{params}#{"\n"*10}")
    user = User.find_or_create_by(name: first_name, phone_number: phone_number)
    product = Product.find_or_create_by(amazon_id: product_id, name: product_name)
    user.messages.create(user_name: user.name, user_number: user.phone_number, product_name: product.name, review_redirect_url: review_redirect_url(product.id))
    return head 200
  end  
end
