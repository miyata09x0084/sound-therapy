class MailformsController < ApplicationController

  def mailform
  end

  def mailform_confirm(post_data=Hash.new)
    post_data['to_email'] = params[:email]
    post_data['from_email'] = current_user.email

    if params['email'].present?
      MailformMailer.mailform(post_data).deliver
      redirect_to root_path, notice: "Sended successfully."
    else
      flash.now[:alert] = "You need to enter a email address."
      render mailforms_mailform_path
    end

  end

end
