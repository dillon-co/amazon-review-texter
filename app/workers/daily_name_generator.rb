require 'unirest'
class DailyNameGenerator
  include Sidekiq::Worker
  def perform
    client = MWS.orders(
      primary_marketplace_id: ENV['AMAZONIAN_MARKETPLACE_ID'],
      merchant_id:            ENV['AMAZONIAN_MERCHANT_ID'],
      aws_access_key_id:      ENV['AMAZONIAN_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AMAZONIAN_SECERET'],  
    )

    t = DateTime.now
    start_time = 2.weeks.ago.beginning_of_day
    puts start_time.hour + 1
    counter = 0
    until start_time.hour.to_i == 22
      begin
        end_time = start_time + 1.hour
        end_time
      
        
        client.list_orders({created_after: "#{start_time.iso8601}", created_before: "#{end_time.iso8601}"}).xml['ListOrdersResponse']['ListOrdersResult']['Orders']['Order'].each do |o| 
          sleep 1
          puts o
          if o.class == Hash
            o = o
          else
            o = o.first
          end  
            if o['OrderStatus'] != "Canceled" 
              
              puts o['OrderStatus']

              puts "#{start_time.hour}\n#{counter+=1}: #{o['BuyerName']} - #{o['ShippingAddress']['Phone']}"  
              order_details = client.list_order_items(o['AmazonOrderId']).xml["ListOrderItemsResponse"]["ListOrderItemsResult"]["OrderItems"]["OrderItem"]
              first_name, last_name = first_and_last_name(o["BuyerName"])
              
              zip = o['ShippingAddress']['PostalCode'].split('-').first
              
              if order_details.class == Hash
                puts order_details["Title"].split(' - ').first
                p_title, order_asin = order_details["Title"].split(' - ').first, order_details['ASIN']
                Client.find_or_create_by(name: "#{first_name} #{last_name}", phone_number: o['ShippingAddress']['Phone'], product_name: p_title, product_id: order_asin, zip_code: zip)
              else  
                puts order_details.first["Title"].split(' - ').first
                p_title, order_asin = order_details.first["Title"].split(' - ').first, order_details.first['ASIN']
                Client.find_or_create_by(name: "#{first_name} #{last_name}", phone_number: o['ShippingAddress']['Phone'], product_name: p_title, product_id: order_asin, zip_code: zip)  
              end  
              
              puts "\n\n#{'='*20}\n\n#{first_name} => #{p_title}\n\n\n\n"
            
              
            else
              next
            end
                
        end  
        start_time = end_time
      rescue => e
        puts e
        # if e.class == "Expected(200) <=> Actual(503 Service Unavailable)"
          sleep 7.minutes
        # end  
        next
      end  
    end


  end 

  def first_and_last_name(name)
    if name.split(' ').count > 1 
     first_name, last_name = name.split(' ') 
    else
     first_name, last_name = "#{name} .".split(' ')
    end 
    [first_name, last_name]
  end  
  
end















