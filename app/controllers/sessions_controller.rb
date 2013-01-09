# encoding: utf-8
#This class handles login and logout.
class SessionsController < ApplicationController
  include ApplicationHelper
  before_filter :set_locale
  #Displays login dialog - unless you're already logged in
  def new
    if current_user
      flash[:notice] = t(:already_logged_in)
      redirect_to root_path
    end
  end
  #Checks passwords and if successful redirects to HP
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = t(:wrong_email_or_password)
      render 'new'
    end
  end
  #Logout, and redirect
  def destroy
    flash[:message] = t(:logged_off)
    sign_out
    redirect_to root_path
  end
end
