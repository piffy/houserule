require 'spec_helper'

describe "groups/edit.html.haml" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "MyString",
      :description => "MyText",
      :user_id => 1,
      :location => "MyString",
      :website_url => "MyString",
      :image_url => "MyString"
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => groups_path(@group), :method => "post" do
      assert_select "input#group_name", :name => "group[name]"
      assert_select "textarea#group_description", :name => "group[description]"
      assert_select "input#group_user_id", :name => "group[user_id]"
      assert_select "input#group_location", :name => "group[location]"
      assert_select "input#group_website_url", :name => "group[website_url]"
      assert_select "input#group_image_url", :name => "group[image_url]"
    end
  end
end
