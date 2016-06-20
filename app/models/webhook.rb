# == Schema Information
#
# Table name: webhooks
#
#  id         :integer          not null, primary key
#  fulldata   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Webhook < ActiveRecord::Base
end
