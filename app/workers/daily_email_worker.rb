class DailyEmailCreator
  include Sidekiq::Worker
  def perform
    client = MWS.orders(
      primary_marketplace_id: ENV['AMAZONIAN_MARKETPLACE_ID'],
      merchant_id:            ENV['AMAZONIAN_MERCHANT_ID'],
      aws_access_key_id:      ENV['AMAZONIAN_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AMAZONIAN_SECERET'],  
    )

    t = DateTime.now
    start_time = 3.days.ago.beginning_of_day
    puts start_time.hour + 1
    counter = 0
    until start_time.hour.to_i == 2
      # begin
        end_time = start_time + 1.hour
        end_time
        client.list_orders({created_after: "#{start_time.iso8601}", created_before: "#{end_time.iso8601}"}).xml['ListOrdersResponse']['ListOrdersResult']['Orders']['Order'].each do |o| 
          if o['OrderStatus'] != "Canceled" 
            order_details = client.list_order_items(o['AmazonOrderId']).xml["ListOrderItemsResponse"]["ListOrderItemsResult"]["OrderItems"]["OrderItem"]
            if Product.find_by(amazon_id: order_details['ASIN']) != nil
              puts o['OrderStatus']
              puts "#{start_time.hour}\n#{counter+=1}: #{o['BuyerName']} - #{o['ShippingAddress']['Phone']}" 

              puts order_details["Title"].split(' - ').first
              first_name, last_name = o['BuyerName'].split(' ')
              p_title = order_details["Title"].split(' - ').first
              puts "\n\n#{'='*20}\n\n#{first_name} => #{p_title}\n\n\n\n"
              c = Client.find_or_create_by(name: first_name, phone_number: o['ShippingAddress']['Phone'], email: o["BuyerEmail"])
              p  = Product.find_by(amazon_id: order_details['ASIN'])
              if p.client_email != nil
                ClintMailer.client_mailer(c, p.client_email).perform_later
              end
            else 
              next
            end    
          else
              next
            end  
        end  
        start_time = end_time  
      # rescue => Excon::Error::ServiceUnavailable
      #   puts e
      #   next
      end     
    end
  end       
end        