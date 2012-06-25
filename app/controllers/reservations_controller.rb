class ReservationsController < ApplicationController
  before_filter :logged_in_user
  before_filter :has_rights_to, only: [:edit, :update, :destroy]

  def new
    @event = Event.find(params[:event_id])
    @user = current_user
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @user = current_user

    case @event.can_be_reserved_by(@user)
      when 1
        #Already reserved
        @error_condition=1
      when true
        #Create reservation and save it
        @reservation = @event.reservations.build(params[:event])
        @reservation.user_id=@current_user.id
        @reservation.status=1; #proposed
        if  @reservation.save
          EventMailer.new_reservation(@reservation).deliver
          flash[:success] = "Prenotazione effettuata. Mail inviata all'organizzatore ("+@event.user.name+")"
          redirect_to event_path(@event)
        else
          flash[:error] = "problemi"
          render 'new'
        end

      else
        flash[:error] = "Errore sconosciuto"
        redirect_to events_path
    end


#    render 'new'
  end

  def show
    @r= Reservation.find(params[:id])
    @event = @r.event
    @user = current_user
    if @user != @r.user
        @reservation_owner="PLALL"
    else
      @reservation_owner=""
    end
    if @event.check_time >0
      flash[:notice] = "Impossibile modificare la prenotazione"
      redirect_to event_path(@event)
    end


  end


  def destroy
    reservation= Reservation.find(params[:id])
    #send confirmation email
    if reservation.user == current_user
      EventMailer.delete_reservation(reservation).deliver
      msg=" Mail inviata all'organizzatore ("+reservation.event.user.name+")"
    else
      EventMailer.delete_reservation(reservation,current_user).deliver
      msg=" Mail inviata all'utente ("+reservation.user.name+")"
    end

    @event = Event.find(params[:event_id])
    reservation.destroy
    flash[:success] = "Prenotazione eliminata."+msg
    redirect_to event_path(@event)
  end

  private

  def has_rights_to
    r = Reservation.find(params[:id])
    unless current_user?(r.user) || current_user?(r.event.user)
      flash[:notice] = "Azione non consentita"
      redirect_to event_path(r.event)
    end
  end

end
