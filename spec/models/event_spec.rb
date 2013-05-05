require 'spec_helper'

describe Event do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, :user => user) }
  before do
    @event = event


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
  it { should respond_to(:percentage) }
  it { should respond_to(:full?) }
  it { should respond_to(:invite_only) }
  it { should respond_to(:reservation_locked) }
  it { should respond_to(:waiting_list) }
  it { should respond_to(:convention_id) }
  its(:user) { should == user }

  describe "when everything is OK" do
    it { should be_valid }
  end

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

  it "should accept a long descripion"  do
    @event.description = "x" * 4000
    @event.should be_valid
  end

  it "should have valid begin date"  do
    @event.begins_at="Not a date";
    @event.should_not be_valid
  end

  #it "should accept nil as begining_date"  do
  #  @event.begins_at=nil;
  #  @event.should be_valid
  #end

  it "should accept both dates as nil"  do
    @event.begins_at=nil;
    @event.deadline=nil;
    @event.should be_valid
  end

  it "should accept nil as deadline"  do
    @event.deadline=nil;
    @event.should be_valid
  end

  #it "should have valid deadline"  do
  #  @event.deadline="Not a date";
  #  @event.should_not be_valid
  #end

  it "should have a plausible deadline"  do
    @event.deadline=@event.begins_at+1.day;
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

  it "should have a valid waiting list value"  do
    @event.waiting_list="String";
    @event.should_not be_valid
    @event.waiting_list=-1;
    @event.should_not be_valid
  end

  describe "Convention"  do
    it "should be linkable to a convention"  do
      convention= FactoryGirl.create(:convention, :user => user)
      convention.save
      @event.convention_id=convention.id
      @event.should be_valid
      @event.convention.name.should == convention.name
      @event.status.should == 4
    end

    it "should be unlinkable with no ill effect"  do
      convention= FactoryGirl.create(:convention, :user => user)
      convention.save
      @event.convention_id=convention.id
      @event.should be_valid
      @event.save
      convention.destroy
      @event.should be_valid
      @event.convention.should be_nil
      @event.status.should == 0
    end

  end


  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Event.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
