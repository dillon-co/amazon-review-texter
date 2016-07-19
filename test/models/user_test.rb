# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  products_id       :integer
#  name              :string
#  phone_number      :string
#  reviews_given     :integer
#  reviews_asked_for :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
