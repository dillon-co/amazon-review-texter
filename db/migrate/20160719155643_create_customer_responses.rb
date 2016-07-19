class CreateCustomerResponses < ActiveRecord::Migration
  def change
    create_table :customer_responses do |t|

      t.belongs_to :client, index: true 
      t.text :message
      t.timestamps null: false
    end
  end
end
