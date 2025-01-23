class ItemImage < ApplicationRecord
  belongs_to :item
 
  validates :url, presence: true, length: { maximum: 255 }
  validates :alt_text, length: { maximum: 255 }
  validates :display_order, uniqueness: { scope: :item_id }
 end