require 'spec_helper'

describe "Groups" do

  let(:user) { FactoryGirl.create(:user) }
  before { @group = user.groups.build(name: "new group") }

  subject { page }

  describe "index" do
    it "responds to index" do
      get groups_path
      response.status.should be(200)
    end
  end
end
