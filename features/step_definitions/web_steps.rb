require 'uri'
require 'cgi'


Then /^dovrei vedere il titolo "([^"]*)"$/ do |title|
  page.should have_selector('title', :text => title)
end

Then /^dovrei essere nella home page$/ do
  assert_equal "/", URI.parse(current_url).path
end

Then /^dovrei essere nella pagina di login$/ do
  assert_equal "/login", URI.parse(current_url).path
end

Given /^(?:|[cC]he )(?:|[Ii]o )mi trovo nella (.+)$/ do |page_name|

  case page_name

    when /^home\s?page$/
      visit '/'

    when /pagina di registrazione/
      visit new_user_path


    when /pagina di creazione evento/
      visit new_event_path

    when /pagina di login/
      visit login_path

    when /pagina di elenco eventi/
      visit events_path

    when /pagina di creazione gruppo/
      visit new_group_path

    else
      raise "Non posso mappare \"#{page_name}\" a un percorso.\n"

  end

end


When /^seleziono la data "[^"](\d?\d)-(\d?\d)-(\d{4})" in "([^"]*)"$/ do  |day,month,year, field|
    #select_date date, :from => field
    select year,                             :from => "#{field}_1i"
    select month,                            :from => "#{field}_2i"
    select day,                              :from => "#{field}_3i"
end


When /^inserisco in "(\w+)" "([^"]*)"$/ do |name,value|
  fill_in name , :with =>value
end

Then /^dovrei vedere il messaggio di errore "([^"]*)"$/ do |text|
  page.should have_css("li", :text => text)
  #page.should have_content(text)
end

Then /^dovrei vedere "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^dovrei non vedere "([^"]*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^dovrei vedere "([^"]*)" all'interno di "([^"]*)"$/ do |text, selector|
  page.should have_css(selector, :text => text)
end

When /^premo "([^"]*)"$/ do |button|
  click_button(button)
end

When /^dovrei vedere il pulsante "([^"]*)"$/ do |name|
  find_button(name).should_not be_nil
end

When /^scelgo "([^"]*)"$/ do |choice|
  choose(choice)
end

When /^seguo il link "([^"]*)"$/ do |link|
  click_link(link)
end

When /mostra la pagina/ do
  save_and_open_page
end

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)
