require 'spec_helper'

describe "groups_event association" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group, :user => user) }
  let(:organizer) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, :user => organizer) }
  it "should allow linking and clearing (group side)" do
    group.events << event
    group.events.count.should == 1
    group.events.delete(event)
    group.events.count.should == 0

  end
  it "should not allow double linking" do
    group.events << event
    expect do
      group.events << event
    end.should raise_error(ActiveRecord::RecordNotUnique)
  end
end