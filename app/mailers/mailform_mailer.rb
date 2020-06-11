class MailformMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailform_mailer.mailform.subject
  #
  def mailform(post_data)
    mail(from: post_data['from_email'], to: post_data['to_email'] , subject: 'Try out Sound therapy')
  end
end


