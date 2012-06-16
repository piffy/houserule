
Allora /^dovrebbe spedire una "([^"]*)" via e\-mail a "([^"]*)"$/ do |action, address|
  @user = User.find_by_email(address)
  @user.email = address
  @email = UserMailer.welcome_email(@user)
  @email.to.should include @user.email
  @email.subject.should include("Registrazione")
  lambda { @email.deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)

end