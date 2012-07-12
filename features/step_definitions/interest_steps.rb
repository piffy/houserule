Allora /^dovrei essere nella pagina di iscrizione gruppo di "([^"]*)"$/ do |group|
  g = Group.find_by_name(group)
  path = new_group_interest_path(g)
  assert_equal path, URI.parse(current_url).path
end
