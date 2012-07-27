Allora /^dovrei trovarmi nella pagina di nuovo annuncio per "([^"]*)"$/ do |event_name|
  e = Event.find_by_name(event_name)
  path = new_event_announcement_path(e)
  assert_equal path, URI.parse(current_url).path
end

E /^vado alla pagina di nuovo annuncio per "([^"]*)"$/ do |event_name|
  e = Event.find_by_name(event_name)
  visit new_event_announcement_path(e)
end


Quando /^inserisco "([^"]*)" nel campo email "([^"]*)"$/ do |email, num|
  fill_in "announcement_email"+num, :with => email
end