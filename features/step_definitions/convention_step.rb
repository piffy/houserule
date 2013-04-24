Allora /^dovrei essere nella pagina di dettagli di una convention$/ do
  c=Convention.first
  assert_equal convention_path(c), URI.parse(current_url).path
end

Dato /^che ci sono (\d+) conventions? di "([^"]*)"$/ do |n, user_email|
  user = User.find_by_email(user_email)
  n.to_i.times {FactoryGirl.create(:convention, :user => user) }
end

E /^che esiste una convention$/ do
  FactoryGirl.create(:convention)
end

E /^vado alla modifica convention$/ do
  c=Convention.first
  visit edit_convention_path(c)
end

Quando /^vado alla pagina di elenco convention$/ do
  visit conventions_path
end

Quando /^vado alla eliminazione della convention "([^"]*)"$/ do |convention_title|
  c = Convention.find_by_name(convention_title)
  c.destroy
end