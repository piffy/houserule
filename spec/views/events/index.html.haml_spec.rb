require 'spec_helper'

describe "events/_list_interested_users.html.haml" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :name => "Name",
        :system => "",
        :duration => "Duration",
        :description => "Description",
        :descr_short => "Descr Short",
        :status => 1,
        :location => "Location",
        :max_player_num => 1,
        :min_player_num => 1,
        :user_id => 1
      ),
      stub_model(Event,
        :name => "Name",
        :system => "",
        :duration => "Duration",
        :description => "Description",
        :descr_short => "Descr Short",
        :status => 1,
        :location => "Location",
        :max_player_num => 1,
        :min_player_num => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Duration".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descr Short".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
