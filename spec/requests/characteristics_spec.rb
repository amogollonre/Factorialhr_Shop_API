require 'swagger_helper'

RSpec.describe 'Characteristics API', type: :request do
  path '/characteristics' do
    get 'Lista características' do
      tags 'Characteristics'
      produces 'application/json'
      
      response '200', 'características encontradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              category_id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              required: { type: :boolean },
              active: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'category_id', 'name', 'required', 'active']
          }
        run_test!
      end
    end

    post 'Crea una característica' do
      tags 'Characteristics'
      consumes 'application/json'
      parameter name: :characteristic, in: :body, schema: {
        type: :object,
        properties: {
          characteristic: {
            type: :object,
            properties: {
              category_id: { type: :integer },
              name: { type: :string, maxLength: 100 },
              description: { type: :string },
              required: { type: :boolean },
              active: { type: :boolean }
            },
            required: ['category_id', 'name']
          }
        }
      }

      response '201', 'característica creada' do
        let(:characteristic) { { characteristic: { category_id: 1, name: 'Color' } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:characteristic) { { characteristic: { name: '' } } }
        run_test!
      end
    end
  end

  path '/characteristics/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene una característica' do
      tags 'Characteristics'
      produces 'application/json'

      response '200', 'característica encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            category_id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            required: { type: :boolean },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        let(:id) { Characteristic.create!(category_id: 1, name: 'Test').id }
        run_test!
      end

      response '404', 'característica no encontrada' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Actualiza una característica' do
      tags 'Characteristics'
      consumes 'application/json'
      parameter name: :characteristic, in: :body, schema: {
        type: :object,
        properties: {
          characteristic: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string },
              required: { type: :boolean },
              active: { type: :boolean }
            }
          }
        }
      }

      response '200', 'característica actualizada' do
        let(:id) { Characteristic.create!(category_id: 1, name: 'Test').id }
        let(:characteristic) { { characteristic: { name: 'Updated' } } }
        run_test!
      end
    end

    delete 'Elimina una característica' do
      tags 'Characteristics'
      
      response '204', 'característica eliminada' do
        let(:id) { Characteristic.create!(category_id: 1, name: 'Test').id }
        run_test!
      end
    end
  end
end