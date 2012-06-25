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

  #Use this method to send to send info to a list of users. Unused in 0.1
  def send_info(sender, event, user_list, information)
    subject "Informazioni su #{event.name}"
    from sender.name
    a=Array.new
    user_list.each { |user| puts a<<user.email }
    recipients a.join(";")
    sent_on Time.now
    body :offer => information
  end


end