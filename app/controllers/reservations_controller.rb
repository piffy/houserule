# encoding: utf-8

class ReservationsController < ApplicationController
  before_filter :logged_in_user
  before_filter :has_rights_to, only: [:edit, :update, :destroy]

  #Ask confirm for reservation
  def new
    @event = Event.find(params[:event_id])
    @user = current_user
    @reservation = Reservation.new
    if @event.invite_only?
      flash.now[:error] = "Questo evento è solo a invito"
    end

  end

  #Ask confirm of reservation
  #Sends email to owner
  def create
    @event = Event.find(params[:event_id])
    @user = current_user
    @invitation=  Invitation.find_by_user_id_and_event_id(@user.id,@event.id)

    case @event.can_be_reserved_by(@user)
      when 1
        #Already reserved
        @error_condition=1
      when 5
        #Only invited
        flash[:error] = "Prenotazione impossibile: evento a inviti"
        redirect_to event_path(@event)
      when 6
        #Only invited
        flash[:error] = "Prenotazione impossibile: prenotazioni bloccate"
        redirect_to event_path(@event)
      when true
        #Create reservation and save it
        @reservation = @event.reservations.build(params[:event])
        @reservation.user_id=@current_user.id
        @reservation.status=1; #proposed
        if  @reservation.save
          unless @invitation.nil?
            @invitation.pending=false
            @invitation.accepted=true
            @invitation.save
          end
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
