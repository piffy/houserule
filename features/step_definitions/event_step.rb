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


Then  /^dovrei essere nella pagina dettagli dell'evento  "([^"]*)"$/ do |event_title|
  event = Event.find_by_name(event_title)
  assert_equal "/events/#{event.id}", URI.parse(current_url).path
end
