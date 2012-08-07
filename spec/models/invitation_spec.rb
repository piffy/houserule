require 'spec_helper'

describe Invitation do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, :user => user) }
  before do
    @invitation = Invitation.new(:event_id => event.id,
                                 :user_id => user.id,
                                 :pending => true,
                                 :accepted => false,
                                 :valid_until => "2013-10-13 18:56:50")
    @invitation.save
  end

  subject { @invitation }

  it { should respond_to(:event_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:pending) }
  it { should respond_to(:accepted) }
  it { should respond_to(:valid_until) }
  it { should respond_to(:expired?) }



  describe "when everything is OK" do
    it { should be_valid }
  end

  it "should relate to an event"  do
    @invitation.event_id=nil
    @invitation.should_not be_valid
  end

  it "should relate to a User"  do
    @invitation.user_id=nil
    @invitation.should_not be_valid
  end

  it "should not allow doubles"  do
    expect do
      @invitation2 = @invitation.dup
      @invitation2.save
    end.should raise_error
  end

  it "should allow destruction" do
    @invitation.save
    n = Invitation.count
    @invitation.destroy
    Invitation.count.should == n-1
  end

  it "should allow check expiry date properly" do
    @invitation.expired?.should == false
    @invitation.valid_until= "2011-10-13 18:56:50"

    @invitation.expired?.should == true
  end

end
