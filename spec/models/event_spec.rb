require 'spec_helper'

describe Event do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is wrong!
    @event = user.events.build(:name => "A name", :system => "A System", :begins_at => "2012-04-04")


  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:system) }
  it { should respond_to(:begins_at) }
  it { should respond_to(:deadline) }
  it { should respond_to(:description) }
  it { should respond_to(:descr_short) }
  it { should respond_to(:name) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "when user_id is not present" do
    before { @event.user_id = nil }
    it { should_not be_valid }
  end
  describe "when name is not present" do
    before { @event.name = nil }
    it { should_not be_valid }
  end

  describe "when name is blank" do
    before { @event.name = "" }
    it { should_not be_valid }
  end

  it "should have a description less than 256 characters"  do
    @event.descr_short = "x" * 256
    @event.should_not be_valid
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Event.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
