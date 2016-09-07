# == Schema Information
#
# Table name: clients
#
#  id           :integer          not null, primary key
#  name         :string
#  email        :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_name :string
#  product_id   :string
#

class Client < ActiveRecord::Base

  has_many :customer_responses
  after_create :send_to_call_center


  def send_to_call_center
    first_name, last_name = name.split(' ')
    post_url = time_zone_urls[time_zone(zip_code)]
    response = Unirest.post post_url, 
                headers:{ "Accept" => "application/json" }, 
                parameters:{ first_name:    first_name,
                             last_name:     last_name, 
                             primary_phone: primary_phone, 
                             zip_code:      zip_code,   
                             product_title: product_name, 
                             product_id:    product_id }
            
    puts "\n\n#{'='*20}\n\n#{first_name} => #{product_name}\n\n\n\n\n\n\n response = #{response.code}\n\n"
  end

  def time_zone_urls
      { "Pacific Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/3241902e-4ab9-11e6-b14d-44a8422b4ea5/',
        "Mountain Timtime_e (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/2e46d24a-4ab9-11e6-ac7d-44a8422b4ea5/',
        "Eastern Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/24c39dd4-4ab9-11e6-b20d-44a8422b4ea5/',
        "Central Time (US & Canada)" => 'https://pp17.perfectpitchtech.com/prospect-upload/29cb7d1a-4ab9-11e6-98d4-44a8422b4ea5/'}
  end  
  
  def time_zone(zip)
    if !!(ActiveSupport::TimeZone.find_by_zipcode(zip_code))
      ActiveSupport::TimeZone.find_by_zipcode(zip_code)
    else
      number = zip_code.match(/[0-9]{3}/).to_s.to_i
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
