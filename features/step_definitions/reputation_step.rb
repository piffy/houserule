Dato /^tutti gli utenti hanno una reputazione$/ do
  User.all.each do |u|
    FactoryGirl.create(:reputation, :user => u)
  end
end