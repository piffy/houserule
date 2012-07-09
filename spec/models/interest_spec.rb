require 'spec_helper'

describe Interest do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:member) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group, :user => user) }
  before do
    @interest = Interest.new(:group_id => group.id,:user_id => member.id )
    @interest.save
  end

  subject { @interest }

  it { should respond_to(:group_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:is_visible) }
  it { should respond_to(:gets_email) }
  it { should respond_to(:is_banned) }
  its(:user) { should == member }


  describe "when everything is OK" do
    it { should be_valid }
  end

  it "should relate to a group"  do
    @interest.group_id=nil
    @interest.should_not be_valid
  end

  it "should relate to a User"  do
    @interest.user_id=nil
    @interest.should_not be_valid
  end

  it "should not allow doubles"  do
    expect do
      @interest2 = @reservation.dup
      @interest2.save
    end.should raise_error
  end

  it "should allow destruction" do
    @interest.save
    n = Interest.count
    @interest.destroy
    Interest.count.should == n-1
  end

  it "should be destroyed when its user is destroyed" do
    @interest.save
    n = Interest.count
    user.destroy
    Interest.count.should == n-1
  end

  it "should be destroyed when its group is destroyed" do
    @interest.save
    n = Interest.count
    group.destroy
    Interest.count.should == n-1
  end

  it "should be have valid visible flag" do
    @interest.is_visible=nil
    @interest.should_not be_valid
  end

  it "should be have valid banned flag" do
    @interest.is_banned=nil
    @interest.should_not be_valid
  end

  it "should be have valid email flag" do
    @interest.gets_email=nil
    @interest.should_not be_valid
  end

end



