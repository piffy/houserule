require 'spec_helper'

describe Reputation do

  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    @reputation = Reputation.new
    @reputation.user_id=user.id
  end

  subject { @reputation }

  it { should respond_to(:user_id) }
  it { should respond_to(:positive_fb) }
  it { should respond_to(:negative_fb) }
  it { should respond_to(:participations) }
  it { should respond_to(:user_name)  }

  describe "when everything is OK" do
    it { should be_valid }
  end

  describe "when user_id is not present" do
    before { @reputation.user_id = nil }
    it { should_not be_valid }
  end

  describe "when the number of positive feedback is negative" do
    before { @reputation.positive_fb = -1 }
    it { should_not be_valid }
  end
  describe "when the number of negative feedback is negative" do
    before { @reputation.negative_fb = -1 }
    it { should_not be_valid }
  end
  describe "when the number of participations is negative" do
    before { @reputation.participations = -1 }
    it { should_not be_valid }
  end
  describe "when the number of organized is negative" do
    before { @reputation.organized = -1 }
    it { should_not be_valid }
  end
  describe "when the number of archived is negative" do
    before { @reputation.archived = -1 }
    it { should_not be_valid }
  end
  it "should return correct score"  do
    @reputation.score.should == 0
    @reputation.organized=1
    @reputation.score.should == 1
    @reputation.positive_fb=20
    @reputation.participations=3
    @reputation.score.should == 23
  end
  it "should return the user name or nick"  do
    @reputation.user_name.should == user.first_name_or_nick
  end


end
