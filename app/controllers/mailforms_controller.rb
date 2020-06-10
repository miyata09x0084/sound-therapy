class MailformsController < ApplicationController

  def mailform
  end

  def mailform_confirm
    post_data = params[:email]
    MailformMailer.mailform(post_data).deliver
  end

end
