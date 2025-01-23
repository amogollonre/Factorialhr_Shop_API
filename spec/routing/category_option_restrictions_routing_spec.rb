require "rails_helper"

RSpec.describe CategoryOptionRestrictionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/category_option_restrictions").to route_to("category_option_restrictions#index")
    end

    it "routes to #show" do
      expect(get: "/category_option_restrictions/1").to route_to("category_option_restrictions#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/category_option_restrictions").to route_to("category_option_restrictions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/category_option_restrictions/1").to route_to("category_option_restrictions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/category_option_restrictions/1").to route_to("category_option_restrictions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/category_option_restrictions/1").to route_to("category_option_restrictions#destroy", id: "1")
    end
  end
end
