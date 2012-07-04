Dato /^che ci sono (\d+) gruppi di "([^"]*)"$/ do |n, user_email|
  user = User.find_by_email(user_email)
  n.to_i.times {FactoryGirl.create(:group, :user => user) }
end

Allora /^dovrei essere nella pagina di elenco gruppo$/ do
  path=groups_path
  assert_equal path, URI.parse(current_url).path
end

Allora /^dovrei essere nella pagina di creazione gruppo$/ do
  path=new_group_path
  assert_equal path, URI.parse(current_url).path
end

E /^vado alla pagina di elenco gruppo$/ do
  visit groups_path
end

Quando /^vado alla eliminazione del gruppo "([^"]*)"$/ do |group_title|
  group = Group.find_by_name(group_title)
  group.destroy
end

Then  /^dovrei essere nella pagina di (\w+) del gruppo "([^"]*)"$/ do |action, group_title|
  group = Group.find_by_name(group_title)
  path = case action
           when "dettagli"
             "/groups/#{group.id}"
           when  "modifica"
             "/groups/#{group.id}/edit"
           when "iscrizione"
             "/groups/#{group.id}/subscription/new"
         end
  assert_equal path, URI.parse(current_url).path
end

E /^che esistono i seguenti gruppi di "([^"]*)":$/ do |user_email, table|
  # table is a Cucumber::Ast::Table

  user = User.find_by_email(user_email)

  table.hashes.each do |group|
    gr=user.groups.build(group)
    gr.save!
    end
end

E /^vado alla (\w+) gruppo di "([^"]*)"$/ do |action,name|
  @group = Group.find_by_name(name)
  case action
    when "modifica"
      visit edit_group_path(@group)
    when "visualizzazione"
      visit group_path(@group)
    when "iscrizione"
      visit new_event_subscription_path(@group)
    else
      raise "Non posso mappare \"#{action}\" a un percorso relativo ad un gruppo!\n"
  end

end