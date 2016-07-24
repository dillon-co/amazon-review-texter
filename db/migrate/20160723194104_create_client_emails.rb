class CreateClientEmails < ActiveRecord::Migration
  def change
    create_table :client_emails do |t|
      t.belongs_to :product, index: true
      t.string :name
      t.string :email
      t.text :body

      t.timestamps null: false
    end
  end
end
