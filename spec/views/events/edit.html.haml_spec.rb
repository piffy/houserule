require 'spec_helper'

describe "events/edit.html.haml" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :name => "MyString",
      :system => "",
      :duration => "MyString",
      :description => "MyString",
      :descr_short => "MyString",
      :status => 1,
      :location => "MyString",
      :max_player_num => 1,
      :min_player_num => 1,
      :user_id => 1
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "input#event_name", :name => "event[name]"
      assert_select "input#event_system", :name => "event[system]"
      assert_select "input#event_duration", :name => "event[duration]"
      assert_select "input#event_description", :name => "event[description]"
      assert_select "input#event_descr_short", :name => "event[descr_short]"
      assert_select "input#event_status", :name => "event[status]"
      assert_select "input#event_location", :name => "event[location]"
      assert_select "input#event_max_player_num", :name => "event[max_player_num]"
      assert_select "input#event_min_player_num", :name => "event[min_player_num]"
      assert_select "input#event_user_id", :name => "event[user_id]"
    end
  end
end
