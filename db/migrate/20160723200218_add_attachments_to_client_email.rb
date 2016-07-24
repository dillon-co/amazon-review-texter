class AddAttachmentsToClientEmail < ActiveRecord::Migration
  def up
    add_attachment :client_emails, :document
  end

  def down
    remove_attachment :client_emails, :document
  end  
end
