Dato /^che esiste la prenotazione dell'evento "([^"]*)" per l'utente "([^"]*)"$/ do |event_name, user_name|
  event = Event.find_by_name(event_name)
  res = Reservation.new
  res.status=1
  if (event.max_player_num)>0 &&  (event.reservations.count>=event.max_player_num)
    res.status=2
  end
  user = User.find_by_email(user_name)
  res.user_id = user.id
  res.event_id = event.id
  res.save
end

Allora /^dovrei essere nella pagina di visualizzazione della prenotazione con id "([^"]*)"$/ do  |id|
  r=Reservation.find_by_id(id);
  e=Event.find_by_id(id)
  path=event_reservation_path(e,r)
  assert_equal path, URI.parse(current_url).path
end

Allora /^vado alla pagina di visualizzazione della prenotazione con id "([^"]*)"$/ do  |id|
  r=Reservation.find_by_id(id);
  e=r.event
  path=event_reservation_path(e,r)
  visit path
end