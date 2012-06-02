require 'spec_helper'

describe Reservation do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  before do
    @reservation = user.reservations.build(:event_id => event.id,
                               :status =>1 )
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

end
