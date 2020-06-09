class MailformMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailform_mailer.mailform.subject
  #
  def mailform
    @greeting = "Hi"

    mail(from: 'miyata09x0084@gmail.com', to: 'miyata09x0084@gmail.com' , subject: 'テストでーす')
  end
end


