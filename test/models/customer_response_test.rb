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

require 'test_helper'

class CustomerResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
