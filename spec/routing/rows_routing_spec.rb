require "spec_helper"

describe RowsController do
  describe "routing" do

    it "routes to #index" do
      get("/rows").should route_to("rows#index")
    end

    it "routes to #new" do
      get("/rows/new").should route_to("rows#new")
    end

    it "routes to #show" do
      get("/rows/1").should route_to("rows#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rows/1/edit").should route_to("rows#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rows").should route_to("rows#create")
    end

    it "routes to #update" do
      put("/rows/1").should route_to("rows#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rows/1").should route_to("rows#destroy", :id => "1")
    end

  end
end
