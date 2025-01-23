require 'rails_helper'

RSpec.describe CategoryOptionRestrictionsController, type: :controller do
  let(:category) { create(:category) }
  let(:characteristic) { create(:characteristic, category: category) }
  let(:if_option) { create(:characteristic_option, characteristic: characteristic) }
  let(:then_option) { create(:characteristic_option, characteristic: characteristic) }
  
  let(:valid_attributes) {
    {
      category_id: category.id,
      if_characteristic_option_id: if_option.id,
      then_characteristic_option_id: then_option.id,
      restriction_type: "incompatible"
    }
  }

  let(:invalid_attributes) {
    { category_id: nil }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new CategoryOptionRestriction' do
        expect {
          post :create, params: { category_option_restriction: valid_attributes }
        }.to change(CategoryOptionRestriction, :count).by(1)
      end

      it 'renders a JSON response with the new restriction' do
        post :create, params: { category_option_restriction: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new CategoryOptionRestriction' do
        expect {
          post :create, params: { category_option_restriction: invalid_attributes }
        }.to change(CategoryOptionRestriction, :count).by(0)
      end
    end
  end
end