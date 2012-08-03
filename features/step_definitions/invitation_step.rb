Dato /^che esiste l'invito all'evento "([^"]*)" per l'utente "([^"]*)"$/ do |event_name, user_name|
  event = Event.find_by_name(event_name)
  user = User.find_by_email(user_name)
  invitation = Invitation.new
  invitation.user_id = user.id
  invitation.event_id = event.id
  invitation.valid_until=event.deadline
  invitation.save!
end

Allora /^dovrei trovarmi nella pagina di nuovi inviti per "([^"]*)"$/ do |event_name|
  e = Event.find_by_name(event_name)
  path = new_event_invitation_path(e)
  assert_equal path, URI.parse(current_url).path
end

E /^vado alla pagina di nuovi inviti per "([^"]*)"$/ do |event_name|
  e = Event.find_by_name(event_name)
  visit new_event_invitation_path(e)
end

Allora /^dovrei trovarmi nella pagina di elenco inviti per "([^"]*)"$/ do |event_name|
  e = Event.find_by_name(event_name)
  path= event_invitations_path(e)
  assert_equal path, URI.parse(current_url).path
end

Allora /^vado alla pagina di elenco inviti per "([^"]*)"$/ do |event_name|
  e = Event.find_by_name(event_name)
  visit event_invitations_path(e)
end

