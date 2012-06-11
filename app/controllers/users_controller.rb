# encoding: utf-8
class UsersController < ApplicationController
  before_filter :logged_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    if current_user
      flash[:notice] = 'Sei già loggato.'
      redirect_to root_path
    end
    @user=User.new

  end
  def edit
    @user=User.find(params[:id] )
    @format=params[:format]

  end
  def update

    @user = User.find(params[:id])
    # This snippet eliminates pw check and confirmation if left blank
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user][:password]=@user.password
      params[:user][:password_confirmation]=@user.password
      #@user.password_confirmation=@user.password
    end
    if @user.update_attributes(params[:user])
      flash[:success] = "Preferenze aggiornate"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  def show
    @user=User.find(params[:id])
    #TODO Paginate
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Utente #{@user.name} creato, ora puoi fare il login"
      redirect_to "/"
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    #TODO You should NOT be able to destroy id #1 (Admin) and #2 (Generic user)
    flash[:success] = "Utente "+@user.name+" eliminato. Addio per sempre!"
    redirect_to "/"
    sign_out
    @user.destroy
  end

  private



end
