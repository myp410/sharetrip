class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: contact.email, bcc: ENV["ACTION_MAILER_USER"], subject: "お問い合わせについて【自動送信】"
  end
end
