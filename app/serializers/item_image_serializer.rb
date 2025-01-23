class ItemImageSerializer < ApplicationSerializer
  attributes :id, :item_id, :url, :alt_text, :is_main, :display_order, :created_at, :updated_at
  belongs_to :item
 end