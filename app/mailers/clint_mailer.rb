require 'open-uri'
class ClintMailer < ApplicationMailer

  default from: "kdbrands01@gmail.com"

  def client_mailer(user, client_email)
    @user, @body = user, client_email.body
    attachments[client_email.document_file_name] = open(client_email.document.url) if @attachment != ''
    mail(to: @user.email, subject: "Follow Up")
  end  


end
