class MailformMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailform_mailer.mailform.subject
  #
  def mailform(post_data)
    mail(from: 'miyata09x0084@gmail.com', to: post_data , subject: 'Try out Sound-therapy')
  end
end


