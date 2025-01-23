class CartItemSerializer < ApplicationSerializer
  attributes :id, :cart_id, :item_id, :selected_options, :final_price, :created_at, :updated_at
  belongs_to :cart
  belongs_to :item
 end