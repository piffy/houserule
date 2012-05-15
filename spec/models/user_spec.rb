require 'spec_helper'

describe User do

  before(:each) do
    @user= User.new
    @user.name = "Example User"
    @user.email =  "user@somedomain.org"
    @user.password= "12345678"
    @user.password_confirmation= "12345678"
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:nick) }
  it { should respond_to(:description) }
  it { should respond_to(:first_name) }
  it { should respond_to(:first_name_or_nick) }
  it { should respond_to(:events) }
  it { should be_valid }

  it "should create a new instance given valid attributes" do
    @user.save
  end

  it "should require a name"  do
    @user.name = ""
    @user.should_not be_valid
  end

  it "should require an email"  do
    @user.email = ""
    @user.should_not be_valid
  end

  it "should have a password between 6 and 15 characters"  do
    @user.password= "x"  * 16
    @user.should_not be_valid
    @user.password= "x" * 5
    @user.should_not be_valid
  end

  it "should have a nick no longer than 15 characters"  do
    @user.nick = "x" * 16
    @user.should_not be_valid
  end

  it "should return name or nick correctly"  do
    @user.first_name.should == "Example"
    @user.first_name_or_nick.should == "Example"
    @user.nick = "different"
    @user.first_name_or_nick.should == "different"
    @user.nick = ""
    @user.first_name_or_nick.should == "Example"
  end

  it "should have a valid email"  do
    @user.email = "x" * 16
    @user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      @user.email = address
      @user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      @user.email = address
      @user.should_not be_valid
    end
  end

  it "should reject duplicate email, case insensitive" do
    @user.save!
    @user_2= User.new
    @user_2.name = "Example User"
    @user_2.email =  "USER@somedomain.org"
    @user_2.password= "12345678"
    @user_2.should_not be_valid
  end
  subject { @user }

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "event associations" do

    before { @user.save }
    let!(:older_event) do
      FactoryGirl.create(:event, user: @user, begins_at: 2.days.ago)
    end
    let!(:newer_event) do
      FactoryGirl.create(:event, user: @user, begins_at: 1.day.ago)
    end

    it "should have the events in the right order" do
      @user.events.should == [newer_event, older_event]
    end

    it "should destroy associated events" do
      events = @user.events
      @user.destroy
      events.each do |event|
        Event.find_by_id(event.id).should be_nil
      end
    end

  end


end
