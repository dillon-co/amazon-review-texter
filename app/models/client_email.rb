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

class ClientEmail < ActiveRecord::Base
  belongs_to :product

  has_attached_file :document 

  validates_attachment :document,
                       :content_type => {:content_type => %w(
                        image/jpeg
                        image/jpg 
                        image/png
                        application/pdf 
                        application/msword 
                        application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

end
