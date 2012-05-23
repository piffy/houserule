Given /^che esistono i seguenti eventi dell'utente "([^"]*)":$/ do |user_email, event_table|

  user = User.find_by_email(user_email)

  event_table.hashes.each do |event|
    event["status"]=1
    event["deadline"]=event["begins_at"]
    ev=user.events.build(event)
    ev.save!
  end

end

Dato /^mi trovo nell'elenco eventi con ordinamento "([^"]*)"$/ do |order|
  visit events_path+"?sort="+order
end

Then /^dovrei vedere "([^"]*)" prima di  "([^"]*)"$/ do |arg1, arg2|
  x=(page.body.index(arg1) < page.body.index(arg2))
  x.should == true
end


E /^vado alla modifica evento di "([^"]*)"$/ do |name|
  @user = Event.find_by_name(name)
  visit edit_event_path(@user)
end


Then  /^dovrei essere nella pagina di (\w+) dell'evento  "([^"]*)"$/ do |action, event_title|
  event = Event.find_by_name(event_title)
  path = case action
           when "dettagli"
             "/events/#{event.id}"
           when  "modifica"
             "/events/#{event.id}/edit"

         end
  assert_equal path, URI.parse(current_url).path
end
