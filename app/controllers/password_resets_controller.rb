# encoding: utf-8
class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:password_reset][:email])
    if @user
      UserMailer.reset_password_email(@user).deliver
      #@user.deliver_password_reset_instructions!
      flash[:success] = "Email di reimpostazione password inviata a #{@user.email}, utilizzare il link contenuto nell'email per reimpostare la password"
      redirect_to root_path
    else
      flash.now[:error] = 'Email o password errata'
      render :action => :new
    end

  end

  def edit
  end

  def update
    @user.password = params[:password_reset][:password]
    @user.password_confirmation = params[:password_reset][:password_confirmation]
    if @user.save
      flash[:success] = "La password è stata aggiornata, puoi fare il login"
      redirect_to login_path
    else
      render :action => :edit
    end
  end


  private
  def require_no_user
  if signed_in?
    flash[:error]= "Sei già loggato"
    redirect_to root_path
  end
  end

  #TODO Add time limit (1d?) to link?
  #TODO Use a different token than remember_token?
  def load_user_using_perishable_token
    @user = User.find_by_remember_token(params[:id])
    unless @user
      flash[:error] = "Account inesistente o link scaduto"
      redirect_to root_url
    end
  end
end
