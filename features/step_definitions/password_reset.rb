Allora /^dovrebbe spedire una mail di reset password a "([^"]*)"$/ do |address|
  @user = User.find_by_email(address)
  @email = UserMailer.reset_password_email(@user)
  @email.to.should include @user.email
  @email.subject.should include("Reset password")
  lambda { @email.deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
end


E /^l'ultima mail dovrebbe contenere il link di reset per "([^"]*)"$/ do |address|
  user = User.find_by_email(address)
  ActionMailer::Base.deliveries.last.should have_content(user.remember_token)
end


E /^l'ultima mail dovrebbe contenere "([^"]*)"$/ do |text|
  ActionMailer::Base.deliveries.last.should have_content(text)
end


Quando /^seguo il link dell'ultima mail$/ do
  regex = /(http:\/\/|www.)([\w-]+\.)+[\w-]+/
  text=ActionMailer::Base.deliveries.last.body.to_s
  url=URI::extract(text)[1]
  visit url
end
