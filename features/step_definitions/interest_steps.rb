# encoding: utf-8
Allora /^dovrei essere nella pagina di iscrizione gruppo di "([^"]*)"$/ do |group|
  g = Group.find_by_name(group)
  path = new_group_interest_path(g)
  assert_equal path, URI.parse(current_url).path
end

Dato /^a "([^"]*)" interessa il gruppo "([^"]*)"$/ do |user_name, group_name|
  user=User.find_by_name(user_name)
  group = Group.find_by_name(group_name)
  user.interests.create( :group_id => group.id)
end

Dato /^"([^"]*)" è bannato dal gruppo "([^"]*)"$/ do |user_name, group_name|
  user=User.find_by_name(user_name)
  group = Group.find_by_name(group_name)
  i=user.interests.build( :group_id => group.id)
  i.is_banned=true
  i.save!
end

Dato /^"([^"]*)" è invisibile nel gruppo "([^"]*)"$/ do |user_name, group_name|
  user=User.find_by_name(user_name)
  group = Group.find_by_name(group_name)
  i=user.interests.build( :group_id => group.id)
  i.is_visible=false
  i.save!
end



Quando /^vado alla modifica interesse di "([^"]*)" per "([^"]*)"$/ do |group_name, user_name|
  user=User.find_all_by_name(user_name).first
  group=Group.find_all_by_name(group_name).first
  r=Interest.where("group_id = ? AND user_id = ?", group.id, user.id).first
  visit edit_group_interest_path(group,r)
end
