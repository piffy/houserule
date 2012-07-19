require 'spec_helper'

describe "Groups" do

  let(:user) { FactoryGirl.create(:user) }
  let(:member) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group, :user => user) }
  let!(:interest) { FactoryGirl.create(:interest, :user => member, :group => group) }

  subject { page }

  describe "index" do
    it "responds to index" do
      get groups_path
      response.status.should be(200)
    end
  end

  describe "show" do
    it "responds to show" do
      visit group_path(group)
      page.should have_selector('h1', text: group.name)
      page.should have_selector('span#group_owner', text: group.user.name)
    end

    it "responds to show when logged in" do
      login FactoryGirl.create(:user)
      visit group_path(group)
      page.should have_selector('h1', text: group.name)
      page.should have_selector('span#group_owner', text: group.user.name)
      page.should have_selector('a', text: member.name)
    end

    it "shows interested users" do
      visit group_path(group)
      page.should have_selector('h1', text: group.name)
      page.should have_selector('span#group_owner', text: group.user.name)
      page.should have_selector('a', text: member.name)
    end
  end
end
