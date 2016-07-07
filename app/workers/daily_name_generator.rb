require 'unirest'
class DailyNameGenerator
  include Sidekiq::Worker
  def perform
    client = MWS.orders(
      primary_marketplace_id: ENV['AMAZONIAN_MARKETPLACE_ID'],
      merchant_id: ENV['AMAZONIAN_MERCHANT_ID'],
      aws_access_key_id: ENV['AMAZONIAN_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AMAZONIAN_SECERET'],
      # auth_token: "Seller's MWS Authorisation Token"  
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
            puts "#{start_time.hour}\n#{counter+=1}: #{o['BuyerName']} - #{o['ShippingAddress']['Phone']}---" 
            product_title = client.list_order_items(o['AmazonOrderId']).xml["ListOrderItemsResponse"]["ListOrderItemsResult"]["OrderItems"]["OrderItem"]["Title"].split(' - ').first
            puts product_title
            puts "\n\n#{'='*20}\n\n"
            response = Unirest.post 'https://pp17.perfectpitchtech.com/prospect-upload/7295eb76-42ed-11e6-96a9-44a8422b4ea5/', 
                                     headers:{ "Accept" => "application/json" }, 
                                    paramaters:{ name: o['BuyerName'], primary_phone: o['ShippingAddress']['Phone'], product_title: product_title, product_id: o['AmazonOrderId'] }
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