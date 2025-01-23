require 'swagger_helper'

RSpec.describe 'Categories API', type: :request do
  path '/categories' do
    get 'Lists all categories' do
      tags 'Categories'
      produces 'application/json'
      
      response '200', 'categories found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string, nullable: true },
              active: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'name', 'active']
          }
        
        run_test!
      end
    end

    post 'Creates a category' do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          category: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Mountain Bikes' },
              description: { type: :string, example: 'All mountain and trail bikes', nullable: true },
              active: { type: :boolean, example: true }
            },
            required: ['name']
          }
        }
      }

      response '201', 'category created' do
        let(:category) { { category: { name: 'Road Bikes', description: 'Racing and endurance bikes' } } }
        
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        
        run_test!
      end

      response '422', 'invalid request' do
        let(:category) { { category: { name: '' } } }
        
        schema type: :object,
          properties: {
            errors: {
              type: :array,
              items: { type: :string }
            }
          }
        
        run_test!
      end
    end
  end

  path '/categories/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a category' do
      tags 'Categories'
      produces 'application/json'
      
      response '200', 'category found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        
        let(:id) { Category.create(name: 'Test Category').id }
        run_test!
      end

      response '404', 'category not found' do
        let(:id) { 'invalid' }
        
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        
        run_test!
      end
    end

    patch 'Updates a category' do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          category: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string },
              active: { type: :boolean }
            }
          }
        }
      }

      response '200', 'category updated' do
        let(:id) { Category.create(name: 'Test Category').id }
        let(:category) { { category: { name: 'Updated Category' } } }
        
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Category.create(name: 'Test Category').id }
        let(:category) { { category: { name: '' } } }
        
        schema type: :object,
          properties: {
            errors: {
              type: :array,
              items: { type: :string }
            }
          }
        
        run_test!
      end
    end

    delete 'Deletes a category' do
      tags 'Categories'
      
      response '204', 'category deleted' do
        let(:id) { Category.create(name: 'Test Category').id }
        run_test!
      end

      response '404', 'category not found' do
        let(:id) { 'invalid' }
        
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        
        run_test!
      end
    end
  end
end