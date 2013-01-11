# encoding: utf-8
#Contrller class for User object
class UsersController < ApplicationController
  before_filter :logged_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
    sort = params[:sort] || session[:sort]

    #Handle sorting
    if sort=='name'
      ordering,@name_header = 'name', 'hilite'
    else
      ordering,@created_at_header = 'created_at', 'hilite'
    end

    #Handle Pagination
    if ordering.nil?
      @users = User.paginate(page: params[:page])
    else
      @users = User.page(params[:page]).order(ordering)
    end


    #Preserve sorting selection in session
    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :selection => @selection and return
    end



  end

  #Register a new user. You can't register if you're logged in.
  def new
    if current_user
      flash[:notice] = 'Sei già loggato.'
      redirect_to root_path
    end
    @user=User.new

  end

  #2 actions here: normal edit and ask for confirmation of deletion
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
    @user_events=@user.events.limit(5)
    @user_reserved_events=@user.reserved_events.slice(0,5)
    @groups=@user.groups
    @reputation = Reputation.new
    #TODO Refactor!
    @interesting_groups=Group.find_by_sql("select groups.* from groups,interests where groups.id=interests.group_id AND interests.user_id="+@user.id.to_s)
    #@groups<<@user.interesting_groups


  end

  #Create user and send welcome mail
  def create
    @user = User.new(params[:user])
    if @user.save
      begin
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Utente #{@user.name} creato, dovresti ricevere una email di conferma. Ora puoi fare il login"
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        flash[:notice] = "Utente #{@user.name} creato. Ora puoi fare il login. Problemi nell'invio mail di conferma"
      end
      redirect_to "/"
    else
      render 'new'
    end
  end

  #Currently wipes out the user completely
  #Should allow a gentlier destroy!
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
