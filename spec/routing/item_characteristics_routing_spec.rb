require "rails_helper"

RSpec.describe ItemCharacteristicsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/item_characteristics").to route_to("item_characteristics#index")
    end

    it "routes to #show" do
      expect(get: "/item_characteristics/1").to route_to("item_characteristics#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/item_characteristics").to route_to("item_characteristics#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/item_characteristics/1").to route_to("item_characteristics#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/item_characteristics/1").to route_to("item_characteristics#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/item_characteristics/1").to route_to("item_characteristics#destroy", id: "1")
    end
  end
end
