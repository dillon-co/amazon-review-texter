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
    until start_time.hour.to_i == 2
      begin
        end_time = start_time + 1.hour
        end_time
        time_zone_urls = { "Pacific Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/3241902e-4ab9-11e6-b14d-44a8422b4ea5/',
                           "Mountain Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/2e46d24a-4ab9-11e6-ac7d-44a8422b4ea5/',
                           "Eastern Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/24c39dd4-4ab9-11e6-b20d-44a8422b4ea5/',
                           "Central Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/29cb7d1a-4ab9-11e6-98d4-44a8422b4ea5/'}
       # byebug
        client.list_orders({created_after: "#{start_time.iso8601}", created_before: "#{end_time.iso8601}"}).xml['ListOrdersResponse']['ListOrdersResult']['Orders']['Order'].each do |o| 
          sleep 0.01
          if o['OrderStatus'] != "Canceled" 
            puts o['OrderStatus']
            puts "#{start_time.hour}\n#{counter+=1}: #{o['BuyerName']} - #{o['ShippingAddress']['Phone']}" 
            order_details = client.list_order_items(o['AmazonOrderId']).xml["ListOrderItemsResponse"]["ListOrderItemsResult"]["OrderItems"]["OrderItem"]

            puts order_details["Title"].split(' - ').first
            first_name, last_name = o['BuyerName'].split(' ')
            p_title = order_details["Title"].split(' - ').first
            puts "\n\n#{'='*20}\n\n#{first_name} => #{p_title}\n\n\n\n"
            Client.find_or_create_by(name: "#{first_name} #{last_name}", phone_number: o['ShippingAddress']['Phone'], product_name: p_title, product_id: order_details['ASIN'])
            zip = o['ShippingAddress']['PostalCode'].split('-').first
            # byebug
            post_url = time_zone_urls[time_zone(zip)]
              response = Unirest.post post_url, 
                                      headers:{ "Accept" => "application/json" }, 
                                      parameters:{ first_name:    first_name,
                                                   last_name:     last_name, 
                                                   primary_phone: o['ShippingAddress']['Phone'], 
                                                   zip_code:      zip,   
                                                   product_title: p_title, 
                                                   product_id:    order_details['ASIN'] }
          
            puts response.code
          else
            next
          end  
        end  
        start_time = end_time
      rescue => e
        puts e
        next
      end  
    end
  end 

  def time_zone(zip)
    if !!(ActiveSupport::TimeZone.find_by_zipcode(zip))
      ActiveSupport::TimeZone.find_by_zipcode(zip)
    else
      number = zip.match(/[0-9]{3}/).to_s.to_i
      time_sone_lookup(number)
    end  
  end 

  def time_sone_lookup(str)
    case str
    when 0..49
      "Eastern Time (US & Canada)" 
    when 50..79
       "Central Time (US & Canada)"
    when 80..87
      "Mountain Time (US & Canada)"
    else 
      "Pacific Time (US & Canada)"
    end      
  end  
end















