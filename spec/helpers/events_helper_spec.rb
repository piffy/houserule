require 'spec_helper'
include EventsHelper

describe EventsHelper do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:user3) { FactoryGirl.create(:user) }
  let!(:user4) { FactoryGirl.create(:user) }
  let!(:user5) { FactoryGirl.create(:user) }
  let!(:full_event) { FactoryGirl.create(:event, :user => user) }
  let!(:waiting_list_event) { FactoryGirl.create(:event, :user => user) }

  it "should see helper methods from included module" do
    update_reservation_status(full_event)
  end
  it "should return nil when called without an event" do
    update_reservation_status(nil).should == nil
  end

  it "should return nil if there are no reservations" do
    update_reservation_status(full_event).should == nil
  end

  describe "without waiting list" do
    before(:each) do
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user.id ).save!
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user2.id ).save!
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user3.id ).save!
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user4.id ).save!
    end

    it "should delete reservation in excess" do
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user5.id ).save!
      expect {
        update_reservation_status(full_event)
      }.to change(Reservation, :count).by(-1)
    end
    it "should return the correct number of deleted reservations" do
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user5.id ).save!
      update_reservation_status(full_event).should == [0,1]
    end
    it "should send email to deleted persons" do
      Reservation.new(:event_id => full_event.id,:status =>1, :user_id => user5.id ).save!
      lambda { update_reservation_status(full_event)}.should change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  describe "with waiting list" do
    before(:each) do
      Reservation.new(:event_id => waiting_list_event.id,:status =>1, :user_id => user.id ).save!
      Reservation.new(:event_id => waiting_list_event.id,:status =>2, :user_id => user2.id ).save!
      Reservation.new(:event_id => waiting_list_event.id,:status =>2, :user_id => user3.id ).save!
      Reservation.new(:event_id => waiting_list_event.id,:status =>2, :user_id => user4.id ).save!
    end

    it "should change the correct number of reservations" do
      update_reservation_status(waiting_list_event).should == [3,0]
      waiting_list_event.reservations.last.user_id.should == user.id
    end

    it "should not delete any reservation reservation in excess" do
      expect {
        update_reservation_status(waiting_list_event)
      }.to change(Reservation, :count).by(0)
    end

    it "should send email to alert involved players" do
      lambda { update_reservation_status(waiting_list_event)}.should change(ActionMailer::Base.deliveries, :count).by(2)
    end

    it "should change reservation status correctly" do
      update_reservation_status(waiting_list_event)
      waiting_list_event.reservations.pluck(:status).should == [1,1,1,1]
    end

    it "should change reservation status correctly" do
      update_reservation_status(waiting_list_event)
      waiting_list_event.reservations.pluck(:status).should == [1,1,1,1]
    end

    it "should work in complex cases" do
      waiting_list_event.waiting_list=1;
      waiting_list_event.max_player_num=2;
      waiting_list_event.save!
      Reservation.find_by_user_id(user.id).destroy
      update_reservation_status(waiting_list_event)
      waiting_list_event.reservations.pluck(:status).should == [1,1,2]
    end

  end



end
