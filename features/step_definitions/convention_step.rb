# encoding: utf-8

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

E /^che esistono le seguenti convention:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |convention|
    convention[:user_id]=User.first.id
    Convention.create!(convention)
  end
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

E /^che la convention si svolge(?:|va) (oggi|ieri)$/ do  |today|
  c=Convention.first
  c.begin_date= Time.now
  c.begin_date=c.begin_date - 1.day unless today=="oggi"
  c.end_date=c.begin_date
  c.save!
end

Dato /^vado alla pagina di visualizzazione di una convention$/ do
  visit convention_path(Convention.first)
end

E /^un evento compatibile attende l'approvazione per una convention$/ do
  c=Convention.first
  e=Event.first
  e.begins_at=c.begin_date
  e.deadline=e.begins_at
  e.save
  c.link(e)
end

E /^l'evento è stato confermato$/ do
  e=Event.first
  e.status=2
  e.save
end

Quando /^la convention viene distrutta$/ do
  c=Convention.first
  c.destroy
end
