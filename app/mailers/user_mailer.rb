class UserMailer < ActionMailer::Base
  default from: "noreplay.houserules@heroku.com"

  #http://stackoverflow.com/questions/4313177/sending-mail-with-rails-3-in-development-environment
  #http://snipplr.com/view/23845/
  #http://stackoverflow.com/questions/4857031/git-deployment-configuration-files-heroku

  def welcome_email(user)
    @user = user
    @url  = ApplicationController.url
    @version = ApplicationController.version
    mail(:to => user.email, :subject => "Registrazione a House Rule")
  end

end
