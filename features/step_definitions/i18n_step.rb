
Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^I should see the image "(.+)"$/ do |image|
  page.should have_xpath("//img[@src=\"/assets/#{image}\"]")
end


Then /^I should see an (italian|english) page$/ do |locale|
  if locale=="english"
    assert_equal "en", URI.parse(current_url).host.split(".").first
  end
end

Then /^I should see "([^"]*)" within "([^"]*)"$/ do |text, selector|
  page.should have_css(selector, :text => text)
end

Then /^I should see the title "([^"]*)"$/ do |title|
  page.should have_selector('title', :text => title)
end

And /^I press "([^"]*)"$/ do |button|
  click_button(button)
end

Given /^the admin user exists$/ do
  FactoryGirl.create(:admin)
end

Given /^a user is logged in$/ do
  u=User.first
  "mi loggo con email \"#{u.email}\" e password \"#{u.password}\""
end

And /^I destroy user "([^"]*)"$/ do |user|
  "vado alla eliminazione dell'utente \"user\""
end

And /^there are (\d+) users?$/ do |n|
  n.to_i.times {FactoryGirl.create(:user) }
end

Given /^I am on the (.+)$/ do |page_name|

  case page_name

    when /^home\s?page$/
      visit root_path

    when /show user page/
      visit "http://en.example.com/users/"+(User.first.id).to_s


    when /edit user page/
      visit "http://en.example.com/users/"+(User.first.id).to_s+"/edit"

    when /login page/
      visit "http://en.example.com/login"

    when /user index page/
      visit "http://en.example.com/users"

    when /pagina di elenco utenti/
      visit users_path

    when /pagina di creazione gruppo/
      visit new_group_path

    when /pagina di collegamento di un gruppo/
      visit new_group_path(Group.first)

    else
      raise "Can't map \"#{page_name}\" to a path.\n"

  end
end