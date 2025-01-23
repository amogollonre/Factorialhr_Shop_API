require 'swagger_helper'

RSpec.describe 'Items API', type: :request do
  path '/items' do
    get 'Lista productos' do
      tags 'Items'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, required: false, description: 'Número de página'
      parameter name: :per_page, in: :query, type: :integer, required: false, description: 'Items por página'
      
      response '200', 'productos encontrados' do
        schema type: :object,
          properties: {
            items: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  category_id: { type: :integer },
                  name: { type: :string },
                  description: { type: :string, nullable: true },
                  base_price: { type: :number },
                  active: { type: :boolean },
                  created_at: { type: :string, format: 'date-time' },
                  updated_at: { type: :string, format: 'date-time' }
                },
                required: ['id', 'category_id', 'name']
              }
            },
            meta: {
              type: :object,
              properties: {
                current_page: { type: :integer },
                total_pages: { type: :integer },
                total_count: { type: :integer },
                per_page: { type: :integer }
              },
              required: ['current_page', 'total_pages', 'total_count', 'per_page']
            }
          },
          required: ['items', 'meta']

        let(:page) { 1 }
        let(:per_page) { 10 }
        run_test!
      end
    end

    post 'Crea un producto' do
      tags 'Items'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          item: {
            type: :object,
            properties: {
              category_id: { type: :integer },
              name: { type: :string, maximum: 100 },
              description: { type: :string },
              base_price: { type: :number, minimum: 0 },
              active: { type: :boolean }
            },
            required: ['category_id', 'name']
          }
        }
      }

      response '201', 'producto creado' do
        let(:item) { { item: { category_id: 1, name: 'Test Product', base_price: 99.99 } } }
        
        schema type: :object,
          properties: {
            id: { type: :integer },
            category_id: { type: :integer },
            name: { type: :string },
            description: { type: :string, nullable: true },
            base_price: { type: :number },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:item) { { item: { name: '' } } }
        
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
  path '/items/by_category/{category_id}' do
    parameter name: :category_id, in: :path, type: :integer, required: true, description: 'ID de la categoría'

    get 'Lista productos por categoría' do
      tags 'Items'
      produces 'application/json'

      response '200', 'productos encontrados para la categoría' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              category_id: { type: :integer },
              name: { type: :string },
              description: { type: :string, nullable: true },
              base_price: { type: :number },
              active: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'category_id', 'name']
          }

        let(:category) { Category.create!(name: 'Bicicletas', description: 'Varias bicicletas') }
        let!(:item1) { Item.create!(category_id: category.id, name: 'Bicicleta de montaña', base_price: 500, active: true) }
        let!(:item2) { Item.create!(category_id: category.id, name: 'Bicicleta de carretera', base_price: 700, active: true) }

        let(:category_id) { category.id }
        run_test!
      end

      response '404', 'no se encontraron productos para la categoría' do
        let(:category_id) { 999 }
        
        schema type: :object,
          properties: {
            error: { type: :string }
          }

        run_test!
      end
    end
  end

  path '/items/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene un producto' do
      tags 'Items'
      produces 'application/json'

      response '200', 'producto encontrado' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            category_id: { type: :integer },
            name: { type: :string },
            description: { type: :string, nullable: true },
            base_price: { type: :number },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }

        let(:id) { Item.create!(category_id: 1, name: 'Test Product').id }
        run_test!
      end

      response '404', 'producto no encontrado' do
        let(:id) { 'invalid' }
        
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        
        run_test!
      end
    end

    patch 'Actualiza un producto' do
      tags 'Items'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          item: {
            type: :object,
            properties: {
              category_id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              base_price: { type: :number },
              active: { type: :boolean }
            }
          }
        }
      }

      response '200', 'producto actualizado' do
        let(:id) { Item.create!(category_id: 1, name: 'Test Product').id }
        let(:item) { { item: { name: 'Updated Name' } } }
        
        schema type: :object,
          properties: {
            id: { type: :integer },
            category_id: { type: :integer },
            name: { type: :string },
            description: { type: :string, nullable: true },
            base_price: { type: :number },
            active: { type: :boolean },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        
        run_test!
      end
    end

    delete 'Elimina un producto' do
      tags 'Items'
      
      response '204', 'producto eliminado' do
        let(:id) { Item.create!(category_id: 1, name: 'Test Product').id }
        run_test!
      end

      response '404', 'producto no encontrado' do
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