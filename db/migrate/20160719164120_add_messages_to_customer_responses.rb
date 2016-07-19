class AddMessagesToCustomerResponses < ActiveRecord::Migration
  def change
    add_reference :customer_responses, :message, index: true
    add_foreign_key :customer_responses, :messages
  end
end
