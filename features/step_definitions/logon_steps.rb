Then /^non sono loggato come utente "(\w+)"/ do |utente|
  "dovrei non vedere \"#{utente}\""
end

Given /^mi loggo con email "([^"]*)" e password "([^"]*)"$/ do |utente, password|
  unless utente.blank?
    visit login_path
    fill_in "Email", :with => utente
    fill_in "Password", :with => password
    click_button "Login"
  end
end


Given /^faccio il logout/ do
  cookies.to_hash.each_pair do |k, v|
    cookies[k.to_sym] = { :value => '',
                          :path => '/',
                          :domain => '.domain.com',
                          :expire => 1.day.ago }
  end
end