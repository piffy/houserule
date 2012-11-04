class EventMailer < ActionMailer::Base
  add_template_helper(EventsHelper)


#use this method to send to event owner that a new reservation has arrived
  def new_reservation(reservation,invitation=nil,mailing_list=nil)
    @event = reservation.event
    @reservation = reservation
    @user = reservation.user
    @organizer = @event.user
    if invitation == nil
      subject = "Nuovo iscritto a #{@event.name}"
      @invitation_message="."
    else
      subject = "Invito per #{@event.name} accettato"
      @invitation_message=" accettando il tuo invito."
    end
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    if mailing_list == nil
      mail(:from => "noreplay.houserules@heroku.com", :to => @organizer.email, :subject => subject )
    else
      mail(:from => "noreplay.houserules@heroku.com", :to => @organizer.email, :subject => subject+ " (lista d'attesa)" )
    end

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

  def upgrade_reservation(reservation,downgrade=0)
    @event = reservation.event
    @reservation = reservation
    @user = reservation.user
    @organizer = @event.user
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    recipient = @user.email
    mail(:from => "noreplay.houserules@heroku.com", :to => recipient, :subject => "Prenotazione a #{@event.name} confermata")
  end



  #Use this method to send info to a list of users.
  def send_message(sender, event, user_list, subject, text)
    @event = event
    @user = sender
    @text = text
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    mail(:from => "noreplay.houserules@heroku.com", :to => user_list, :subject => subject )
  end

  #Use this method to send admin info to a list of users.
  def send_admin_message(sender, user_list, subject, text)
    @user = sender
    @text = text
    mail(:from => "noreplay.houserules@heroku.com", :to => user_list, :subject => subject )
  end

  #Use this method to announce an event
  def announcement(organizer, event, user_list)
    @event = event
    @user = organizer
    @url  = root_url(:host => ApplicationController.hostname)+"events/"+@event.id.to_s
    hypothetical=@event.begins_at.blank? ? " in cantiere" : ""
    mail(:from => "noreplay.houserules@heroku.com", :to => user_list, :subject => "Nuovo evento#{hypothetical}: #{event.name}")


    end


end