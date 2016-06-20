# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  product_id          :integer
#  sms_message         :text
#  user_number         :string
#  user_name           :string
#  product_name        :string
#  review_redirect_url :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :product
  after_save :send_message

   def send_message
    @twilio_number = '+13853753097'
    api = Twilio::REST::Client.new ENV['AMAZONIAN_TWILIO_ACCOUNT_SID'], ENV['AMAZONIAN_TWILIO_AUTH_TOKEN']
    messages = user_message.scan(/.{1,800}/m)
    messages.each do |msg|
      api.messages.create(
        :from => @twilio_number,
        :to => user_reformatted_number,
        :body => msg
      ).status
    end 
  end

  def user_reformatted_number
    user_number.gsub(/[^\d]/, '')
  end  

  def user_message
    bit_link = bitly_link
    # "Hey #{user_name}, this is Dillon from the app. I'm running some tests, Text me if you get this message."
    "Hey #{user_name}, thanks in advance for leaving a quick review. Just follow this link \n#{bit_link} \n\n\nLet me know if you have any questions!"
  end 

  def bitly_link
    bitly_object = Bitly.client.shorten(review_redirect_url)
    bitly_object.short_url
  end  
end

