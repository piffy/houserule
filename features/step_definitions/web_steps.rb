require 'uri'
require 'cgi'


Quando /^premo il pulsante "([^"]*)"$/ do |button|
  click_button(button)
end

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

    when /pagina di elenco utenti/
      visit users_path

    when /pagina di creazione gruppo/
      visit new_group_path

    when /pagina di collegamento di un gruppo/
      visit new_group_path(Group.first)


    when /pagina di elenco reputazioni/
      visit reputations_path

    when /pagina di modifica reputazione di un utente/
      visit edit_reputation_path(Reputation.last)

    when /pagina di creazione convention/
      visit new_convention_path

    else
      raise "Non posso mappare \"#{page_name}\" a un percorso.\n"

  end

end

Quando /^vado alla pagina di amministrazione$/ do
  visit administration_path
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

Then /^dovrei vedere un link per "([^"]*)"$/ do |link|
  page.should have_selector('a', {:href=>link})
end

Then /^dovrei non vedere "([^"]*)" all'interno di "([^"]*)"$/ do |text, selector|
  page.should_not have_css(selector, :text => text)
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


When /debugga la pagina/ do
  save_and_open_page
  true
end

When /^deseleziono la casella "([^"]*)"$/ do |arg1|
  uncheck(arg1)
end

When /^seleziono la casella "([^"]*)"$/ do |arg1|
  check(arg1)
end

Quando /^seleziono la prima casella$/ do
  check(find("input[type='checkbox']"))
end

Then /^il campo "([^\"]*)" dovrebbe contenere "([^\"]*)"$/ do |field, value|
  field_labeled(field).value.should =~ /#{value}/
end

Then /^dovrei( non)? vedere il campo "([^"]*)"$/ do |negate, name|
  expectation = negate ? :should_not : :should
  begin
    field = find_field(name)
  rescue Capybara::ElementNotFound
    # In Capybara 0.4+ #find_field raises an error instead of returning nil
  end
  field.send(expectation, be_present)
end


module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)
