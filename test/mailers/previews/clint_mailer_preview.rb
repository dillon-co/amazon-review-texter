# Preview all emails at http://localhost:3000/rails/mailers/clint_mailer
class ClintMailerPreview < ActionMailer::Preview
  def mail_preview
    ClintMailer.client_mailer(Client.last, ClientEmail.last)
  end  
end
