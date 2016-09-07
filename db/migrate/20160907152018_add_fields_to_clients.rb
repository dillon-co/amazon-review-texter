class AddFieldsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :primary_phone, :string
    add_column :clients, :zip_code, :string
  end
end
