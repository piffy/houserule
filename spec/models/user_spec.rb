require 'spec_helper'

describe User do

  before(:each) do
    @user= User.new
    @user.name = "Example User"
    @user.email =  "user@somedomain.org"
    @user.password= "12345678"
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password)}
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
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


  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end



end
