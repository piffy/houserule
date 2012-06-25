
Then /^il sistema ha inviato (\d+) emails?$/ do |email_count|
  ActionMailer::Base.deliveries.size.to_s.should == email_count
end


Then /^il sistema non ha ancora inviato emails?$/ do
  ActionMailer::Base.deliveries = []
end

Allora /^dovrebbe spedire una mail di conferma registrazione a "([^"]*)"$/ do |address|
  @user = User.find_by_email(address)
  @email = UserMailer.welcome_email(@user)
  @email.to.should include @user.email
  @email.subject.should include("Registrazione")
  lambda { @email.deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
end



Allora /^dovrebbe spedire una mail di conferma cancellazione prenotazione con id "([^"]*)" all'"([^"]*)"$/ do |arg1,person|
  case person
    when /organizzatore/
      reservation=Reservation.find_by_id(arg1)
      email = EventMailer.delete_reservation(reservation)
      email.to.should include reservation.event.user.email
      lambda {email.deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    when /utente/
      reservation=Reservation.find_by_id(arg1)
      organizer=reservation.event.user
      email = EventMailer.delete_reservation(reservation,organizer)
      email.to.should include reservation.user.email
      lambda {email.deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    else
      raise "Errore!"
  end


end