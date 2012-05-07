require 'uri'
require 'cgi'





Given /^(?:|[cC]he )(?:|[Ii]o )mi trovo nella (.+)$/ do |page_name|

  case page_name

    when /^home\s?page$/
      visit '/'

    when /pagina di registrazione/
      visit new_user_path

    when /pagina di login/
      visit login_path

    else
      raise "Non posso mappare \"#{page_name}\" a un percorso.\n"

  end

end

When /^inserisco in "(\w+)" "([^"]*)"$/ do |name,value|
  fill_in name , :with =>value
end

Then /^dovrei vedere il messaggio di errore "(.+)"$/ do |text|
  page.should have_css("li", :text => text)
  #page.should have_content(text)
end

Then /^dovrei vedere "(.+)"$/ do |text|
  page.should have_content(text)
end

Then /^dovrei non vedere "(.+)"$/ do |text|
  page.should_not have_content(text)
end

When /^premo "([^"]*)"$/ do |button|
  click_button(button)
end

When /^seguo il link "([^"]*)"$/ do |link|
  "I follow \"#{link}\""
end

When /mostra la pagina/ do
  save_and_open_page
end
