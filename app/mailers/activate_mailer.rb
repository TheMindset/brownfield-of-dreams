# frozen_string_literal: true

class ActivateMailer < ApplicationMailer
  def register(current_user)
    @user = current_user
    mail(to: current_user.email, subject: "Activate Your Brownfield Account")
  end

  def invita(user, handle)
    @user = user
    @inviter_handle = handle
    mail(to: email, subject: "Invitation to join Brownfield")
  end
end
