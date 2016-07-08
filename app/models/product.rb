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

class Product < ActiveRecord::Base
  has_many :users

  before_save: update_review_url

  
  def update_review_url
    amazon_review_url ||= "https://www.amazon.com/review/create-review/ref=cm_cr_dp_wrt_summary?ie=UTF8&asin=#{amazon_id}#"  
  end  

end
