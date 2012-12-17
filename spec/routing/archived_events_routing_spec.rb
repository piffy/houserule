require "spec_helper"

describe ArchivedEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/archived_events").should route_to("archived_events#index")
    end

    it "routes to #show" do
      get("/archived_events/1").should route_to("archived_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/archived_events/1/edit").should route_to("archived_events#edit", :id => "1")
    end

    it "routes to #update" do
      put("/archived_events/1").should route_to("archived_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/archived_events/1").should route_to("archived_events#destroy", :id => "1")
    end

  end
end
