Allora /^dovrei essere nella pagina di iscrizione gruppo di "([^"]*)"$/ do |group|
  g = Group.find_by_name(group)
  path = new_group_interest_path(g)
  assert_equal path, URI.parse(current_url).path
end


E /^che i seguenti utenti sono interessati al gruppo "([^"]*)"$/ do |group_name, table|
  # table is a Cucumber::Ast::Table
  group = Group.find_by_name(group_name)
  table.map_headers!(/user_name/i => :user_id)

  table.hashes.each do |interest|
    user=User.find_by_name(interest[:user_id])
    interest[:user_id]=user.id
    i=group.interests.build(interest)
    i.save!
  end
end


