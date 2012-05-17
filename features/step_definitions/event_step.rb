Given /^che esistono i seguenti eventi dell'utente "([^"]*)":$/ do |user_email, event_table|

  user = User.find_by_email(user_email)

  event_table.hashes.each do |event|
    ev=user.events.build(event)
    ev.save!
  end

end