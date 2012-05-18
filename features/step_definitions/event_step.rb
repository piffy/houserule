Given /^che esistono i seguenti eventi dell'utente "([^"]*)":$/ do |user_email, event_table|

  user = User.find_by_email(user_email)

  event_table.hashes.each do |event|
    ev=user.events.build(event)
    ev.save!
  end

end


Then /^dovrei vedere "([^"]*)" prima di  "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end