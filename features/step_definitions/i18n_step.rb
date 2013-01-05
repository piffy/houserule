Given /^I am on the (italian|english)? homepage$/ do |locale|
  if locale=="english"
    visit root_path.gsub(/(http:\/\/)(en|it|www)(.+)/, '\1en\3')
  end
  visit root_path
end

Then /^I should see "([^"]*)"$/ do |arg1|
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