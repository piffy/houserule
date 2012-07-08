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
  #its(:user) { should == user }


end



