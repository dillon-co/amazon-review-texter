class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :name
      t.string :amazon_review_url
      
      t.integer :amazon_id
      t.integer :review_count, default: 0

      t.timestamps null: false
    end
  end
end
