require 'spec_helper'

describe "groups/new.html.haml" do
  before(:each) do
    assign(:group, stub_model(Group,
      :name => "MyString",
      :description => "MyText",
      :user_id => 1,
      :location => "MyString",
      :website_url => "MyString",
      :image_url => "MyString"
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => groups_path, :method => "post" do
      assert_select "input#group_name", :name => "group[name]"
      assert_select "textarea#group_description", :name => "group[description]"
      assert_select "input#group_user_id", :name => "group[user_id]"
      assert_select "input#group_location", :name => "group[location]"
      assert_select "input#group_website_url", :name => "group[website_url]"
      assert_select "input#group_image_url", :name => "group[image_url]"
    end
  end
end
