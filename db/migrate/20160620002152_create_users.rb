class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :products, index: true

      t.string  :name
      t.string  :phone_number
      t.integer :reviews_given
      t.integer :reviews_asked_for

      t.timestamps null: false
    end
  end
end
