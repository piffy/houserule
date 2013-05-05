require 'spec_helper'

describe Convention do
  let(:user) { FactoryGirl.create(:user) }
  let!(:convention) { FactoryGirl.create(:convention, :user => user) }
  before do
    @convention = convention
  end


  subject { @convention }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:website_url) }
  it { should respond_to(:image_url) }
  it { should respond_to(:user) }
  it { should respond_to(:begin_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:facebook_url) }
  it { should respond_to(:linked_event_check)  }
  it { should respond_to(:image_url_or_default) }
  its(:user) { should == user }



  describe "when everything is OK" do
    it { should be_valid }
  end

  describe "when user_id is not present" do
    before { @convention.user_id = nil }
    it { should_not be_valid }
  end
  describe "when name is not present" do
    before { @convention.name = nil }
    it { should_not be_valid }
  end

  describe "when location is blank" do
    before { @convention.location= "" }
    it { should_not be_valid }
  end

  describe "when location is not present" do
    before { @convention.location= nil }
    it { should_not be_valid }
  end


  it "should not accept invalid begin date"  do
    @convention.begin_date="Not a date";
    @convention.should_not be_valid
    @convention.begin_date=nil
    @convention.should_not be_valid
  end

  it "should not accept invalid invalid end date"  do
    @convention.end_date="Not a date";
    @convention.should_not be_valid
    @convention.end_date=nil
    @convention.should_not be_valid
  end

  it "should have a plausible deadline"  do
    @convention.end_date=@convention.begin_date-1.day;
    @convention.should_not be_valid
  end


  describe "accessible attributes" do
    it "should allow access to user_id" do
      expect do
        Convention.new(user_id: user.id)
      end.should_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "linking events"  do
    it "should be linkable to a compatible event"  do
      event= FactoryGirl.create(:event, :user => user)
      event.begins_at=@convention.begin_date
      event.deadline=@convention.begin_date
      event.should be_valid
      event.save
      @convention.compatible_with?(event).should be_true
      @convention.link(event).should be_true
    end

    it "should not be linkable to an incompatible event"  do
      event= FactoryGirl.create(:event, :user => user)
      event.begins_at=@convention.begin_date-1.day
      event.deadline=@convention.begin_date-1.day
      event.should be_valid
      event.save
      @convention.compatible_with?(event).should be_false
      @convention.link(event).should be_false
    end

    it "should not be linkable to an indetermined event"  do
      event= FactoryGirl.create(:event, :user => user)
      event.begins_at=nil
      event.deadline=nil
      event.should be_valid
      event.save
      @convention.compatible_with?(event).should be_false
      @convention.link(event).should be_false
    end

    it "should be unlinkable with no ill effect"  do
      event= FactoryGirl.create(:event, :user => user)
      event.save
      event.convention_id=@convention.id
      event.should be_valid
      event.convention.name.should == @convention.name
      @convention.destroy
      event.should be_valid
      #event.convention.should be_nil
    end

  end


end
