require 'spec_helper'

describe Group do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    @group = user.groups.build(:name => "Group name" )
  end

  subject { @group }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:website_url) }
  it { should respond_to(:image_url) }
  it { should respond_to(:user) }
  it { should respond_to(:image_url_or_default) }
  its(:user) { should == user }


  describe "when everything is OK" do
    it { should be_valid }
  end


    it "should create a new instance given valid attributes" do
    @group.save
  end

  it "should require name to exist"  do
    @group.name = nil
    @group.should_not be_valid
  end

  it "should require a name"  do
    @group.name = ""
    @group.should_not be_valid
  end

  it "should have a valid url for website, if it has one"  do
    #@group.website_url = "http://"+ Faker::Internet.domain_word+"+"+Faker::Internet.domain_suffix
    @group.should be_valid
    @group.website_url = "http://www.houserule.it"
    @group.should be_valid
    @group.website_url = "Certainly_not_an_url"
    @group.should_not be_valid
  end

  it "should have add the http:// prefix if it's missing"  do
    @group.website_url = "www.houserule.it"
    @group.image_url = "www.houserule.it/image.jpg"
    @group.save
    @group.website_url.should == "http://www.houserule.it"
    @group.image_url.should == "http://www.houserule.it/image.jpg"
  end



  it "should have a valid url for images, if it has one"  do
    @group.should be_valid
    @group.image_url = "http://www.houserule.it/icon.jpg"
    @group.should be_valid
    @group.image_url = "Certainly_not_an_url"
    @group.should_not be_valid
  end

  it "should reject duplicate names, case insensitive" do
    @group.save!
    @group_2= Group.new
    @group_2.name = @group.name
    @group_2.should_not be_valid
  end


  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Group.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end


