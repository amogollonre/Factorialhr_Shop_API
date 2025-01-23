require "rails_helper"

RSpec.describe OptionImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/option_images").to route_to("option_images#index")
    end

    it "routes to #show" do
      expect(get: "/option_images/1").to route_to("option_images#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/option_images").to route_to("option_images#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/option_images/1").to route_to("option_images#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/option_images/1").to route_to("option_images#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/option_images/1").to route_to("option_images#destroy", id: "1")
    end
  end
end
