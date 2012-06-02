require 'spec_helper'

describe Reservation do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }
  before do
    @reservation = user.reservations.build(:event_id => event.id,
                               :status =>1 )
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
      @reservation2 = user.reservations.create(:event_id => event.id,
                                        :status =>1 )
    end.should raise_error

  end


end
