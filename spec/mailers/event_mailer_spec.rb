require "spec_helper"

describe UserMailer do
  let!(:organizer) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, :user => organizer) }
  let!(:reservation) { FactoryGirl.create(:reservation, :user => user, :event => event) }

  before(:each) do
    ActionMailer::Base.deliveries = []
  end


  it 'should send email to organizer when a new reservation arrives' do
    lambda { EventMailer.new_reservation(reservation).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Nuovo iscritto a #{event.name}/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(organizer.email)
  end

  it 'should send email to organizer when a user deletes reservation' do
    lambda { EventMailer.delete_reservation(reservation).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Prenotazione a #{event.name} cancellata/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(organizer.email)
  end

  it 'should send email to user when the organizers deletes his reservation' do
    lambda { EventMailer.delete_reservation(reservation,organizer).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Prenotazione a #{event.name} cancellata/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(user.email)
  end

  it 'should send email to user and organizer when an admin deletes a reservation' do
    lambda { EventMailer.delete_reservation(reservation,admin).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Prenotazione a #{event.name} cancellata/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(user.email)
    sent.first.to.should include(organizer.email)
  end


  def sent
    ActionMailer::Base.deliveries
  end
end