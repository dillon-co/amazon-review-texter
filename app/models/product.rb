# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  name              :string
#  amazon_review_url :string
#  amazon_id         :string
#  review_count      :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

#  review_count      :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :users
  has_one :client_email



  
  def updated_review_url
    amazon_review_url.presence || "https://www.amazon.com/review/create-review/ref=cm_cr_dp_wrt_summary?ie=UTF8&asin=#{amazon_id}#"  
  end  

end
