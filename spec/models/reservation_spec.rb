require 'spec_helper'

describe Reservation do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, :user => user) }
  before do
    @reservation = Reservation.new(:event_id => event.id,:status =>1, :user_id => user.id )
    @reservation.save
  end

  subject { @reservation }

  it { should respond_to(:event_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:status) }



  describe "when everything is OK" do
    it { should be_valid }
  end

  it "should have a valid status"  do
    @reservation.status="String";
    @reservation.should_not be_valid
  end

  it "should relate to an event"  do
    @reservation.event_id=nil
    @reservation.should_not be_valid
  end

  it "should relate to a User"  do
    @reservation.user_id=nil
    @reservation.should_not be_valid
  end

  it "should not allow doubles"  do
    expect do
      @reservation2 = @reservation.dup
      @reservation2.save
    end.should raise_error
  end

  it "should allow destruction" do
    @reservation.save
    n = Reservation.count
    @reservation.destroy
    Reservation.count.should == n-1
  end

  it "should be destroyed when its user is destroyed" do
    @reservation.save
    n = Reservation.count
    user.destroy
    Reservation.count.should == n-1
  end

  it "should be destroyed when its event is destroyed" do
    @reservation.save
    n = Reservation.count
    event.destroy
    Reservation.count.should == n-1
  end


end
