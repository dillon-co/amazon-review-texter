require 'unirest'
class DailyNameGenerator
  include Sidekiq::Worker
  def perform
    client = MWS.orders(
      primary_marketplace_id: ENV['AMAZONIAN_MARKETPLACE_ID'],
      merchant_id: ENV['AMAZONIAN_MERCHANT_ID'],
      aws_access_key_id: ENV['AMAZONIAN_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AMAZONIAN_SECERET'],  
    )

    t = DateTime.now
    start_time = 2.weeks.ago.beginning_of_day
    puts start_time.hour + 1
    counter = 0
    until start_time.hour.to_i == 2
      begin
        end_time = start_time + 1.hour
        end_time
        client.list_orders({created_after: "#{start_time.iso8601}", created_before: "#{end_time.iso8601}"}).xml['ListOrdersResponse']['ListOrdersResult']['Orders']['Order'].each do |o| 
          if o['OrderStatus'] != "Canceled" 
            puts o['OrderStatus']
            puts "#{start_time.hour}\n#{counter+=1}: #{o['BuyerName']} - #{o['ShippingAddress']['Phone']}" 
            order_details = client.list_order_items(o['AmazonOrderId']).xml["ListOrderItemsResponse"]["ListOrderItemsResult"]["OrderItems"]["OrderItem"]
            # byebug\
            puts order_details["Title"].split(' - ').first
            first_name, last_name = o['BuyerName'].split(' ')
            order_details["Title"].split(' - ').first
            puts "\n\n#{'='*20}\n\n"
            response = Unirest.post 'https://pp17.perfectpitchtech.com/prospect-upload/7295eb76-42ed-11e6-96a9-44a8422b4ea5/', 
                                    headers:{ "Accept" => "application/json" }, 
                                    parameters:{ first_name:    first_name,
                                                 last_name:     last_name, 
                                                 primary_phone: o['ShippingAddress']['Phone'], 
                                                 zip_code:      o['ShippingAddress']['PostalCode'].split('-').first,   
                                                 product_title: order_details["Title"].split(' - ').first, 
                                                 product_id:    order_details['ASIN'] }
            
            puts response.code
          else
            next
          end  
        end  
        start_time = end_time
      rescue Excon::Error::ServiceUnavailable => e
        puts e
        next
      end  
    end
  end  
end  