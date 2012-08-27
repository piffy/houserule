module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def current_user=(user)
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def logged_in_user
    unless signed_in?
      store_location
      flash[:notice] = "Effettuare prima il login"
      redirect_to login_path
    end


    def correct_user
      @user = User.find(params[:id])
      #@user=user_from_remember_token
      unless current_user?(@user) || current_user.admin?
        flash[:notice] = "Azione non consentita"
        redirect_to(root_path)
      end
    end

    def correct_event_for_user
        @event = Event.find(params[:id])
        unless current_user?(@event.user) || current_user.admin?
          flash[:notice] = "Azione non consentita"
          redirect_to(event_path(@event))
        end
    end

    def correct_event_related_to_user
      @event = Event.find(params[:event_id])
      unless current_user?(@event.user) || current_user.admin?
        flash[:notice] = "Azione non consentita"
        redirect_to(event_path(@event))
      end
    end

  end


  private

  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end



  def clear_return_to
    session.delete(:return_to)
  end


end