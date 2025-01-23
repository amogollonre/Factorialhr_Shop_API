require 'swagger_helper'

RSpec.describe 'Category Option Restrictions API', type: :request do
  path '/category_option_restrictions' do
    get 'Lista restricciones' do
      tags 'Category Option Restrictions'
      produces 'application/json'
      
      response '200', 'restricciones encontradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              category_id: { type: :integer },
              if_characteristic_option_id: { type: :integer },
              then_characteristic_option_id: { type: :integer },
              restriction_type: { type: :string },
              active: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'category_id', 'if_characteristic_option_id', 'then_characteristic_option_id']
          }
        run_test!
      end
    end

    post 'Crea una restricción' do
      tags 'Category Option Restrictions'
      consumes 'application/json'
      parameter name: :restriction, in: :body, schema: {
        type: :object,
        properties: {
          category_option_restriction: {
            type: :object,
            properties: {
              category_id: { type: :integer },
              if_characteristic_option_id: { type: :integer },
              then_characteristic_option_id: { type: :integer },
              restriction_type: { type: :string },
              active: { type: :boolean }
            },
            required: ['category_id', 'if_characteristic_option_id', 'then_characteristic_option_id']
          }
        }
      }

      response '201', 'restricción creada' do
        let(:restriction) { { category_option_restriction: { 
          category_id: 1, 
          if_characteristic_option_id: 1, 
          then_characteristic_option_id: 2 
        } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:restriction) { { category_option_restriction: { category_id: nil } } }
        run_test!
      end
    end
  end

  path '/category_option_restrictions/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene una restricción' do
      tags 'Category Option Restrictions'
      produces 'application/json'

      response '200', 'restricción encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            category_id: { type: :integer },
            if_characteristic_option_id: { type: :integer },
            then_characteristic_option_id: { type: :integer },
            restriction_type: { type: :string },
            active: { type: :boolean }
          }
        let(:id) { CategoryOptionRestriction.create!(
          category_id: 1,
          if_characteristic_option_id: 1,
          then_characteristic_option_id: 2
        ).id }
        run_test!
      end
    end

    patch 'Actualiza una restricción' do
      tags 'Category Option Restrictions'
      consumes 'application/json'
      parameter name: :restriction, in: :body, schema: {
        type: :object,
        properties: {
          category_option_restriction: {
            type: :object,
            properties: {
              restriction_type: { type: :string },
              active: { type: :boolean }
            }
          }
        }
      }

      response '200', 'restricción actualizada' do
        let(:id) { CategoryOptionRestriction.create!(
          category_id: 1,
          if_characteristic_option_id: 1,
          then_characteristic_option_id: 2
        ).id }
        let(:restriction) { { category_option_restriction: { active: false } } }
        run_test!
      end
    end

    delete 'Elimina una restricción' do
      tags 'Category Option Restrictions'
      
      response '204', 'restricción eliminada' do
        let(:id) { CategoryOptionRestriction.create!(
          category_id: 1,
          if_characteristic_option_id: 1,
          then_characteristic_option_id: 2
        ).id }
        run_test!
      end
    end
  end
end