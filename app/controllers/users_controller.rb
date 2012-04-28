class UsersController < ApplicationController
  def new
    @user=User.new

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
end
