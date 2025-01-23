require 'swagger_helper'

RSpec.describe 'Item Images API', type: :request do
  path '/item_images' do
    get 'Lista imágenes de productos' do
      tags 'Item Images'
      produces 'application/json'
      
      response '200', 'imágenes encontradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              item_id: { type: :integer },
              url: { type: :string },
              alt_text: { type: :string },
              is_main: { type: :boolean },
              display_order: { type: :integer },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['item_id', 'url']
          }
        run_test!
      end
    end

    post 'Crea imagen de producto' do
      tags 'Item Images'
      consumes 'application/json'
      parameter name: :item_image, in: :body, schema: {
        type: :object,
        properties: {
          item_image: {
            type: :object,
            properties: {
              item_id: { type: :integer },
              url: { type: :string },
              alt_text: { type: :string },
              is_main: { type: :boolean },
              display_order: { type: :integer }
            },
            required: ['item_id', 'url']
          }
        }
      }

      response '201', 'imagen creada' do
        let(:item_image) { { item_image: { 
          item_id: 1,
          url: 'http://example.com/image.jpg'
        } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:item_image) { { item_image: { item_id: nil } } }
        run_test!
      end
    end
  end

  path '/item_images/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene una imagen de producto' do
      tags 'Item Images'
      produces 'application/json'
      response '200', 'imagen encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            item_id: { type: :integer },
            url: { type: :string },
            alt_text: { type: :string },
            is_main: { type: :boolean },
            display_order: { type: :integer }
          }
        let(:id) { ItemImage.create!(
          item_id: 1,
          url: 'http://example.com/image.jpg'
        ).id }
        run_test!
      end
    end

    patch 'Actualiza imagen de producto' do
      tags 'Item Images'
      consumes 'application/json'
      parameter name: :item_image, in: :body, schema: {
        type: :object,
        properties: {
          item_image: {
            type: :object,
            properties: {
              url: { type: :string },
              alt_text: { type: :string },
              is_main: { type: :boolean },
              display_order: { type: :integer }
            }
          }
        }
      }

      response '200', 'imagen actualizada' do
        let(:id) { ItemImage.create!(
          item_id: 1, 
          url: 'http://example.com/image.jpg'
        ).id }
        let(:item_image) { { item_image: { alt_text: 'Nueva descripción' } } }
        run_test!
      end
    end

    delete 'Elimina imagen de producto' do
      tags 'Item Images'
      response '204', 'imagen eliminada' do
        let(:id) { ItemImage.create!(
          item_id: 1,
          url: 'http://example.com/image.jpg'
        ).id }
        run_test!
      end
    end
  end
end