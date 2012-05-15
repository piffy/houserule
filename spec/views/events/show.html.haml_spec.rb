require 'spec_helper'

describe "events/show.html.haml" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :name => "Nome",
      :system => "System",
      :duration => "3 ore",
      :description => "Description",
      :descr_short => "Descr Short",
      :status => 1,
      :location => "Location",
      :max_player_num => 0,
      :min_player_num => 0,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Nome/)
    rendered.should match(/System/)
    rendered.should match(/3 ore/)
    rendered.should match(/Description/)
    rendered.should match(/Descr Short/)
    rendered.should match(/0/)
    rendered.should match(/Location/)
    rendered.should match(/1/)
  end
end
