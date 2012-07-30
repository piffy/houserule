class EventMailer < ActionMailer::Base
  add_template_helper(EventsHelper)


#use this method to send to event owner that a new reservation has arrived
  def new_reservation(reservation)
    @event = reservation.event
    @reservation = reservation
    @user = reservation.user
    @organizer = @event.user
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    mail(:from => "noreplay.houserules@heroku.com", :to => @organizer.email, :subject => "Nuovo iscritto a #{@event.name}")
  end

#Use this method to send to event owner or player that a reservation has been deleted
  def delete_reservation(reservation,admin=nil)
    @event = reservation.event
    @reservation = reservation
    @user = reservation.user
    @organizer = @event.user
    @admin=admin
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    if @admin.nil?
      mail(:from => "noreplay.houserules@heroku.com", :to => @organizer.email, :subject => "Prenotazione a #{@event.name} cancellata")
    else
      recipients = @user.email + ( (admin==@organizer)  ? "": (";"+@organizer.email) )
      mail(:from => "noreplay.houserules@heroku.com", :to => recipients, :subject => "Prenotazione a #{@event.name} cancellata")
    end

  end

  #Use this method to send info to a list of users.
  def send_message(sender, event, user_list, subject, text)
    @event = event
    @user = sender
    @text = text
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    mail(:from => "noreplay.houserules@heroku.com", :to => user_list, :subject => subject )
  end

  #Use this method to announce an event
  def announcement(organizer, event, user_list)
    @event = event
    @user = organizer
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    mail(:from => "noreplay.houserules@heroku.com", :to => user_list, :subject => "Nuovo evento: #{event.name}")

  end


end