require "spec_helper"

describe ConventionsController do
  describe "routing" do

    it "routes to #index" do
      get("/conventions").should route_to("conventions#index")
    end

    it "routes to #new" do
      get("conventions/new").should route_to("conventions#new")
    end

    it "routes to #show" do
      get("/conventions/1").should route_to("conventions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/conventions/1/edit").should route_to("conventions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/conventions").should route_to("conventions#create")
    end

    it "routes to #update" do
      put("/conventions/1").should route_to("conventions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/conventions/1").should route_to("conventions#destroy", :id => "1")
    end

  end
end
