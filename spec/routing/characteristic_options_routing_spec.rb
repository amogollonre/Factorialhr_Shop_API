require "rails_helper"

RSpec.describe CharacteristicOptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/characteristic_options").to route_to("characteristic_options#index")
    end

    it "routes to #show" do
      expect(get: "/characteristic_options/1").to route_to("characteristic_options#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/characteristic_options").to route_to("characteristic_options#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/characteristic_options/1").to route_to("characteristic_options#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/characteristic_options/1").to route_to("characteristic_options#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/characteristic_options/1").to route_to("characteristic_options#destroy", id: "1")
    end
  end
end
