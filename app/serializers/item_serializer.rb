class ItemSerializer < ApplicationSerializer
  attributes :id, :category_id, :name, :description, :base_price, :active, :created_at, :updated_at
  belongs_to :category
  has_many :item_images
  has_many :item_characteristics
 end