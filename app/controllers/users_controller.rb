class UsersController < ApplicationController
  before_filter :logged_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user=User.new

  end
  def edit
    @user=User.find(params[:id] )

  end
  def update

    @user = User.find(params[:id])
    # This snippet eliminates pw check and confirmation if left blank
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
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

  private

  def logged_in_user
    unless signed_in?
      store_location
      flash[:notice] = "Effettuare prima il login"
      redirect_to login_path
    end

  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
