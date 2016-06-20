# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  phone_number      :string
#  reviews_given     :integer
#  reviews_asked_for :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ActiveRecord::Base
  has_many :products

end
