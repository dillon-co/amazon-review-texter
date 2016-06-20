# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  name              :string
#  amazon_review_url :string
#  amazon_id         :integer
#  review_count      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
