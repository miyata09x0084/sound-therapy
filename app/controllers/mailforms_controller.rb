class MailformsController < ApplicationController

  def mailform
  end

  def mailform_confirm(post_data=Hash.new)

    if user_signed_in?

      if params[:email].present?
        post_data['to_email'] = params[:email]
        post_data['from_email'] = current_user.email

        MailformMailer.mailform(post_data).deliver
        redirect_to root_path, notice: "Sended successfully."
      else
        flash.now[:alert] = "You need to enter a email address."
        render mailforms_mailform_path
      end

    else
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
    end

  end

end
