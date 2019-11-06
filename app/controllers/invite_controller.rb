# frozen_string_literal: true

class InviteController < ApplicationController
  def new; end

  def create
    if current_user.github_token.nil?
      flash[:error] = "You must be connected to Github to invite new users"
    else
      user = find_github_user(current_user.github_token, params[:"Github Handle"])
      if user.keys.include?(:message) && user[:message] = "Not Found"
        flash[:error] = "Github user not found"
      elsif user[:email].nil?
        flash[:error] = "The user you selected doesn't have an email associated with their account."
      else
        flash[:success] = "Successfully sent the invitation!"
        ActivateMailer.invite(user, current_user.github_user_nickname).deliver_now
      end
    end
    redirect_to dashboard_path
  end

  private

  def service(token)
    @service ||= GithubService.new(token)
  end

  def find_github_user(token, handle)
    @find_github_user ||= service(token).user_search(handle)
  end
end
