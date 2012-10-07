# encoding: utf-8

Given /^un evento è collegato al gruppo "([^"]*)"$/ do |group_name|
  group=Group.find_by_name(group_name)
  group.events << Event.first
end