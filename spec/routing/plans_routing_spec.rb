require "spec_helper"

describe PlansController do
  describe "routing" do

    it "routes to #index" do
      get("/plans").should route_to("plans#index")
    end

    #it "routes to #show" do
    #  get("/plans/1").should route_to("plans#show", :id => "1")
    #end

  end
end
