class ReservationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @user = current_user
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @user = current_user

    case @event.can_be_reserved_by(@user)
      when true
        #Create reservation and save it
        @reservation = @event.reservations.build(params[:event])
        @reservation.user_id=@current_user.id
        @reservation.status=1; #proposed
        if  @reservation.save
          flash[:success] = "Prenotazione effettuata!"
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

  def delete
  end
end
