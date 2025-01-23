class CartSerializer < ApplicationSerializer
  attributes :id, :user_id, :status, :created_at, :updated_at
  has_many :cart_items
 end