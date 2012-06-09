# encoding: utf-8
class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = 'Sei già loggato.'
      redirect_to root_path
    end
  end
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Email o password errata'
      render 'new'
    end
  end

  def destroy
    flash[:message] = 'Scollegato.'
    sign_out
    redirect_to root_path
  end
end
