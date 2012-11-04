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

  it 'should send email to organizer when a new reservation arrives in the waiting list' do
    lambda { EventMailer.new_reservation(reservation,nil,true).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Nuovo iscritto a #{event.name}/#correct subject
    sent.first.subject.should =~ /attesa/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(organizer.email)
  end

  it 'should send email to promoted user when somenone deletes his reservation' do
    lambda { EventMailer.upgrade_reservation(reservation).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /#{event.name} confermata/#correct subject
    sent.first.subject.should =~ /confermata/#correct subject
    sent.first.body.should include(event.name) #correct
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

  it 'should send email to user list for a new event' do
    lambda { EventMailer.announcement(organizer, event, user.email+";"+organizer.email).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Nuovo evento: #{event.name}/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(user.email)
    sent.first.to.should include(organizer.email)
    sent.first.body.should include(organizer.name)
  end

  it 'should send email to user list for a new event even when without dates' do
    event.begins_at = nil
    event.deadline=nil
    event.status = 0
    lambda { EventMailer.announcement(organizer, event, user.email+";"+organizer.email).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should =~ /Nuovo evento in cantiere: #{event.name}/#correct subject
    sent.first.body.should include(event.name) #correct
    sent.first.to.should include(user.email)
    sent.first.to.should include(organizer.email)
    sent.first.body.should include(organizer.name)
  end


  it 'should send info email to user(s)' do
    text = Faker::Lorem.paragraph(3)
    subject = Faker::Lorem.words(1)[0]
    lambda { EventMailer.send_message(admin, event, user.email, subject, text).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should include(subject) #correct subject
    sent.first.body.should include(text) #correct
    sent.first.to.should include(user.email)
    sent.first.body.should include(admin.name)
  end

  it 'should send changed date message to user(s)' do
    event.begins_at=nil
    event.deadline=nil
    text = Faker::Lorem.paragraph(3)
    subject = Faker::Lorem.words(1)[0]
    lambda { EventMailer.send_message(admin, event, user.email, subject, "changed_date").deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should include(subject) #correct subject
    sent.first.body.should include("evento in questione ha modificato la data") #correct
    sent.first.body.should include("evento ora non ha alcuna data fissata") #correct
    sent.first.to.should include(user.email)
    sent.first.body.should include(admin.name)
  end

  it 'should send info admin email to user(s)' do
    text = Faker::Lorem.paragraph(3)
    subject = Faker::Lorem.words(1)[0]
    lambda { EventMailer.send_admin_message(organizer, user.email, subject, text).deliver}.should change(ActionMailer::Base.deliveries, :count).by(1)
    sent.first.subject.should include(subject) #correct subject
    sent.first.body.should include(text) #correct
    sent.first.to.should include(user.email)
    sent.first.body.should include(organizer.name)
  end


  def sent
    ActionMailer::Base.deliveries
  end
end