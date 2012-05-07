class SessionsController < ApplicationController
  def new
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
