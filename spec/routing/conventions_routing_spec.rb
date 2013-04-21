require "spec_helper"

describe ConventionsController do
  describe "routing" do

    it "routes to #index" do
      get("/conventions").should route_to("conventions#index")
    end

    it "routes to #new" do
      get("users/1/conventions/new").should route_to("conventions#new", :user_id => "1")
    end

    it "routes to #show" do
      get("/conventions/1").should route_to("conventions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/conventions/1/edit").should route_to("conventions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/users/1/conventions").should route_to("conventions#create", :user_id => "1")
    end

    it "routes to #update" do
      put("/conventions/1").should route_to("conventions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/conventions/1").should route_to("conventions#destroy", :id => "1")
    end

  end
end
