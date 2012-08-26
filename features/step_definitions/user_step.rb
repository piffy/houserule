


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
    user["password_confirmation"]=user["password"]
    User.create!(user)
  end


end


Dato /^(?:|che )ci sono (\d+) utenti$/ do |n|
  n.to_i.times {FactoryGirl.create(:user) }
end


Dato /^(?:|che )esiste l'utente amministratore "([^"]*)"$/ do |email|
  user=FactoryGirl.create(:admin)
  user.email=email
  user.save!
end


E /^vado alla modifica preferenze di "([^"]*)"$/ do |username|
  @user = User.find_by_email(username)
  visit edit_user_path(@user)
end

Quando /^vado alla modifica preferenze di un utente$/ do
  @user = User.last
  visit edit_user_path(@user)
end

Given  /^vado al profilo dell'utente "([^"]*)"$/ do |username|
  @user = User.find_by_email(username)
  visit user_path(@user)
end

Quando /^vado alla eliminazione dell'utente "([^"]*)"$/ do |username|
  user = User.find_by_email(username)
  user.should be
  Capybara.current_session.driver.delete user_path(user.id)
end