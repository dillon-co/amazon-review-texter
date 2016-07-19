
class CustomerResponsesController < ApplicationController

  def new_response
    c = Client.find_or_create_by(phone_number: params["From"])
    c.customer_response.create(message: params['Body'])
  end  
end
