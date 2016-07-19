# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  sms_message          :text
#  user_number          :string
#  user_name            :string
#  product_name         :string
#  review_redirect_url  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  customer_response_id :integer
#

require 'texting_worker'
class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer_response
  before_save :user_message
  after_save :create_client
  after_save :call_text_message_worker

   def send_message
    @user_message = user_message
    @user_reformatted_number = user_reformatted_number
    api = Twilio::REST::Client.new ENV['AMAZONIAN_TWILIO_ACCOUNT_SID'], ENV['AMAZONIAN_TWILIO_AUTH_TOKEN']
    # api = Twilio::REST::Client.new 'SM20a3c42c7f224e7fb3fa5ae69c5a4098', ENV['AMAZONIAN_TWILIO_AUTH_TOKEN']
    api.messages.create(
      :from => '+13852009830',
      :to => @user_reformatted_number,
      :body => sms_message
    )
  end

  def user_reformatted_number
    puts user_number
    user_number.gsub(/[^\d]/, '')
  end  


  def user_message  
    sms_message ||= "Hey, thanks in advance for leaving a quick review. Just follow this link\n#{review_redirect_url}\n\n\nLet me know if you have any questions!"
  end  



  def call_text_message_worker

    TextWorker.perform_async(self.id)
  end  
end

