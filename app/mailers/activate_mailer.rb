# frozen_string_literal: true

class ActivateMailer < ApplicationMailer
  def register(current_user)
    @user = current_user
    mail(to: current_user.email, subject: "Activate Your Brownfield Account")
  end

  def invite(user, github_nickname)
    @user = user
    @github_nickname = github_nickname
    mail(to: @user[:email], subject: "Invitation to join Brownfield")
  end
end
