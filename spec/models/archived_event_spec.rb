require 'spec_helper'

describe ArchivedEvent do


    let(:user) { FactoryGirl.create(:user) }
    let!(:event) { FactoryGirl.create(:archived_event, :user => user) }
    before do
      @event =  event

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
    it { should respond_to(:aftermath) }


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
      @event.status.should == 4
    end




end
