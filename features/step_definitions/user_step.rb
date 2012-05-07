
Then /^dovrei essere alla  home\s?page$/ do
  request.request_uri.should == "/"
  response.should be_success
end

Then /^dovrei essere alla pagina di registrazione$/ do
  request.request_uri.should == new_user_path
  response.should be_success
end

Then /^dovrei essere alla pagina utente$/ do
  request.request_uri.should == user_path
  response.should be_success
end


Given /(?:|che )esistono i seguenti utenti/ do |user_table|

  user_table.hashes.each do |user|

    User.create!(user)
  end

end


E /^vado alla modifica preferenze di "([^"]*)"$/ do |username|
  @user = User.find_by_email(username)
  visit edit_user_path(@user)
end
