Allora /^dovrei essere nella pagina di elenco gruppo$/ do
  path=groups_path
  assert_equal path, URI.parse(current_url).path
end

Allora /^dovrei essere nella pagina di creazione gruppo$/ do
  path=new_group_path
  assert_equal path, URI.parse(current_url).path
end


Then  /^dovrei essere nella pagina di (\w+) del gruppo "([^"]*)"$/ do |action, event_title|
  event = Group.find_by_name(event_title)
  path = case action
           when "dettagli"
             "/groups/#{event.id}"
           when  "modifica"
             "/groups/#{event.id}/edit"
           when "prenotazione"
             "/groups/#{event.id}/reservations/new"
         end
  assert_equal path, URI.parse(current_url).path
end

