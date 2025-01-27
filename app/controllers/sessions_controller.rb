# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @new ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged as #{user.first_name} #{user.last_name}"
      redirect_to dashboard_path
    else
      flash[:error] = "Looks like your email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:githb_id] = nil
    redirect_to root_path
  end
end
