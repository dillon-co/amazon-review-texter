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
#

class Client < ActiveRecord::Base

  has_many :customer_responses
end
