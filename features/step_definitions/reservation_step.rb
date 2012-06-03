Dato /^che esiste la prenotazione dell'evento "([^"]*)" per l'utente "([^"]*)"$/ do |event_name, user_name|
  event = Event.find_by_name(event_name)
  res = Reservation.new
  res.status=1
  user = User.find_by_email(user_name)
  res.user_id = user.id
  res.event_id = event.id
  res.save
end