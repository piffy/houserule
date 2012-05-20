require 'spec_helper'

describe Event do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @event = user.events.build(:name => "A name", :system => "A System", :begins_at => "2012-05-13 18:56:50")


  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:system) }
  it { should respond_to(:begins_at) }
  it { should respond_to(:deadline) }
  it { should respond_to(:description) }
  it { should respond_to(:descr_short) }
  it { should respond_to(:max_player_num) }
  it { should respond_to(:location) }
  it { should respond_to(:status) }
  it { should respond_to(:min_player_num) }
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

  it "should have a short description less than 256 characters"  do
    @event.descr_short = "x" * 256
    @event.should_not be_valid
  end

  it "should have valid begin date"  do
    @event.begins_at="Not a date";
    @event.should_not be_valid
  end

  it "should have valid deadline"  do
    @event.deadline="Not a date";
    @event.should_not be_valid
  end

  it "should have possibile deadline or none at all"  do
    @event.deadline=@event.begins_at+1.day;
    @event.should_not be_valid
    @event.deadline=@event.begins_at;
    @event.should_not be_valid
  end

  it "should have valid player numbers"  do
    @event.max_player_num="String"
    @event.should_not be_valid
    @event.min_player_num="String"
    @event.should_not be_valid
    @event.max_player_num=-1;
    @event.should_not be_valid
    @event.max_player_num=5;
    @event.min_player_num=-1;
    @event.should_not be_valid
  end

  it "should have min_player greater than max player"  do
    @event.max_player_num=5;
    @event.min_player_num=6;
    @event.should_not be_valid
  end

  it "should have a valid status"  do
    @event.status="String";
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
