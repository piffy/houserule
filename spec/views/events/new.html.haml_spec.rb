require 'spec_helper'

describe "events/new.html.haml" do
  before(:each) do
    assign(:event, stub_model(Event,
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
    ).as_new_record)
  end

  it "renders new event form" do
    render
    rendered.should match(/Nuovo evento per/)
    assert_select "form", :action => events_path, :method => "post" do
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