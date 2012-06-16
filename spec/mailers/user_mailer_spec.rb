require "spec_helper"

describe UserMailer do
  let(:user) { FactoryGirl.create(:user) }


  before(:each) do
    ActionMailer::Base.deliveries = []
  end

=begin
#TODO Should really send a multipart/alternative message. As of now, just html.
  it "should generate a multipart message (plain text and html)" do
    mail=UserMailer.welcome_email(user)
    mail.body.parts.length.should eq(2)
    mail.body.parts.collect(&:content_type).should == ["text/plain; charset=UTF-8", "text/html; charset=UTF-8"]
  end


  it "should generate a message with username and URL in both parts" do
    url_regex = /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/
    mail=UserMailer.welcome_email(user)
    mail.body.parts.length.should eq(2)
    mail.body.parts.collect(&:content_type).should == ["text/plain; charset=UTF-8", "text/html; charset=UTF-8"]
    get_message_part(mail, /plain/).should include(user.name)
    get_message_part(mail, /plain/).should match(url_regex)
    get_message_part(mail, /html/).should include(user.name)
    get_message_part(mail, /html/).should match(url_regex)
  end
=end

  it 'should send welcome email' do
    url_regex = /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/
    lambda { UserMailer.welcome_email(user).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Registrazione a House Rule/#correct subject
    sent.first.body.should include(user.name) #correct username
    sent.first.body.should =~ url_regex #has an URL
  end


  def sent
    ActionMailer::Base.deliveries
  end
end