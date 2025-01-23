require "rails_helper"

RSpec.describe ItemImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/item_images").to route_to("item_images#index")
    end

    it "routes to #show" do
      expect(get: "/item_images/1").to route_to("item_images#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/item_images").to route_to("item_images#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/item_images/1").to route_to("item_images#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/item_images/1").to route_to("item_images#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/item_images/1").to route_to("item_images#destroy", id: "1")
    end
  end
end
