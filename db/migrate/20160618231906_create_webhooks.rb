class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.text :fulldata

      t.timestamps null: false
    end
  end
end
