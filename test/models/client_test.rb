# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  name          :string
#  email         :string
#  phone_number  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_name  :string
#  product_id    :string
#  primary_phone :string
#  zip_code      :string
#

require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
