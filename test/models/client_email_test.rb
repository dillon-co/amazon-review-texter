# == Schema Information
#
# Table name: client_emails
#
#  id                    :integer          not null, primary key
#  product_id            :integer
#  name                  :string
#  email                 :string
#  body                  :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#

require 'test_helper'

class ClientEmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
