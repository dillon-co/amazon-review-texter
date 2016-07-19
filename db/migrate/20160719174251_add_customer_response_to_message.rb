class AddCustomerResponseToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :customer_response, index: true, foreign_key: true
  end
end
