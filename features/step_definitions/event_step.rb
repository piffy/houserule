# encoding: utf-8

Given /^l'evento "([^"]*)" è "([^"]*)"$/ do |event_name, condition|
  event = Event.find_by_name(event_name)
  if condition=="riservato"
    event.invite_only=true
    event.save
  end
  if condition=="bloccato"
    event.reservation_locked=true
    event.save
  end
end

Given /^che esistono i seguenti eventi dell'utente "([^"]*)":$/ do |user_email, event_table|

  user = User.find_by_email(user_email)

  event_table.hashes.each do |event|
    event["status"]=1
    if event["deadline"].nil?
      event["deadline"]=event["begins_at"]
    end
    #hash=FactoryGirl.attributes_for(:event)
    #hash.merge(event)
    ev=user.events.build(event)
    ev.save!
  end

end

Dato /^(?:|che )ci sono (\d+) eventi? ?(passati|indefiniti)? di "([^"]*)"$/ do |n, past, user_email|
  user = User.find_by_email(user_email)
  #FactoryGirl.reload
  if past.blank?
  n.to_i.times {FactoryGirl.create(:event, :user => user) }
  elsif past=='passati'
  n.to_i.times {u=FactoryGirl.create(:event, :user => user);
                u.name="Past "+u.name; u.begins_at-=1.year;
                u.deadline-=1.year; u.save}
  elsif past=='indefiniti'
    n.to_i.times {u=FactoryGirl.create(:event, :user => user);
                  u.name="Indefinite "+u.name; u.begins_at=nil;u.status=0;
                  u.deadline=nil; u.save}
  end

end

Dato /^mi trovo nell'elenco eventi con ordinamento "([^"]*)"$/ do |order|
  visit events_path+"?sort="+order
end

Then /^dovrei vedere "([^"]*)" prima di  "([^"]*)"$/ do |arg1, arg2|
  x=(page.body.index(arg1) < page.body.index(arg2))
  x.should == true
end

Quando /^vado alla modifica di un evento$/ do
  @event = Event.first
  visit edit_event_path(@event)
end

Quando /^vado ai dettagli di un evento$/ do
  @event = Event.first
  visit event_path(@event)
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


E /^inserisco in "([^"]*)" la data di ieri$/ do |field|
  if true
     d=(Date.today-1.day).to_formatted_s(:db)
  end
  "inserisco in \"#{field}\" \"#{d}\""
end
