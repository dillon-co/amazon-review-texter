# == Schema Information
#
# Table name: customer_responses
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :integer
#

class CustomerResponse < ActiveRecord::Base

  belongs_to :client
  has_many :messages

  after_save :forward_message


  def forward_message
    if client.phone_number == '8056038329'
      user_name, full_message = message.split(' - ', 2)
      c = Client.find_by(name: user_name)
      messages.create(user_number: c.phone_number, sms_messaage: full_message)
    else  
      messages.create(user_number: '8056038329', sms_message: clients_message)
    end  
  end
  
  def clients_message
    "From #{client.name}:\n\n #{message}"
  end
    

end
