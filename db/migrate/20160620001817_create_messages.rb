class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :product, index: true
      t.text   :sms_message
      t.string :user_number
      t.string :user_name
      t.string :product_name
      t.string :review_redirect_url

      t.timestamps null: false
    end
  end
end
