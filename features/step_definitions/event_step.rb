Given /^che esistono i seguenti eventi dell'utente "([^"]*)":$/ do |user_email, event_table|

  user = User.find_by_email(user_email)

  event_table.hashes.each do |event|
    event["status"]=1
    if event["deadline"].nil?
      event["deadline"]=event["begins_at"]
    end
    ev=user.events.build(event)
    ev.save!
  end

end

Dato /^(?:|che )ci sono (\d+) eventi? ?(passati)? di "([^"]*)"$/ do |n, past, user_email|
  user = User.find_by_email(user_email)
  #FactoryGirl.reload
  if past.blank?
  n.to_i.times {FactoryGirl.create(:event, :user => user) }
  else
  n.to_i.times {u=FactoryGirl.create(:event, :user => user);
                u.name="Past "+u.name; u.begins_at-=1.year;
                u.deadline-=1.year; u.save}
  end

end

Dato /^mi trovo nell'elenco eventi con ordinamento "([^"]*)"$/ do |order|
  visit events_path+"?sort="+order
end

Then /^dovrei vedere "([^"]*)" prima di  "([^"]*)"$/ do |arg1, arg2|
  x=(page.body.index(arg1) < page.body.index(arg2))
  x.should == true
end


E /^vado alla (\w+) evento di "([^"]*)"$/ do |action,name|
  @event = Event.find_by_name(name)
  case action
    when "modifica"
      visit edit_event_path(@event)
    when "visualizzazione"
      visit event_path(@event)
    when "prenotazione"
      visit new_event_reservation_path(@event)
    else
      raise "Non posso mappare \"#{action}\" a un percorso relativo ad un evento!\n"
  end

end


Then  /^dovrei essere nella pagina di (\w+) dell'evento  "([^"]*)"$/ do |action, event_title|
  event = Event.find_by_name(event_title)
  path = case action
           when "dettagli"
             "/events/#{event.id}"
           when  "modifica"
             "/events/#{event.id}/edit"
           when "prenotazione"
             "/events/#{event.id}/reservations/new"
         end
  assert_equal path, URI.parse(current_url).path
end
