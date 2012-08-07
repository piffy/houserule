require "spec_helper"

describe UserMailer do
  let!(:organizer) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, :user => organizer) }
  let!(:invitation) { FactoryGirl.create(:invitation, :user => user, :event => event) }
  let!(:reservation) { FactoryGirl.create(:reservation, :user => user, :event => event) }


  before(:each) do
    ActionMailer::Base.deliveries = []
  end


  it 'should send email to invited' do
    lambda { InvitationMailer.new_invitation(invitation).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Invito per #{event.name}/#correct subject
    sent.first.body.should include(event.name) #correct event name
    sent.first.to.should include(user.email)
  end

  it 'should send email to the already invited' do
    lambda { InvitationMailer.new_invitation(invitation,true).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Invito per #{event.name}/  #correct subject
    sent.first.subject.should =~/\(sollecito\)/#correct subject
    sent.first.body.should include(event.name) #correct event name
    sent.first.to.should include(user.email)
  end

  it 'should send email to organizer in case the invitation is rejected' do
    lambda { InvitationMailer.deny_invitation(invitation).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Invito per #{event.name} rifiutato/  #correct subject
    sent.first.body.should include(event.name) #correct event name
    sent.first.body.should include(user.name) #correct user name
    sent.first.to.should include(organizer.email)
  end

  it 'should send email to organizer when a reservation is accepted' do
    lambda { EventMailer.new_reservation(reservation,invitation).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Invito per #{event.name} accettato/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.body.should include("accettando") #correct formula
    sent.first.to.should include(organizer.email)
  end

  def sent
    ActionMailer::Base.deliveries
  end
end