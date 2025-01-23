class Item < ApplicationRecord
  belongs_to :category
  has_many :item_images
  has_many :item_characteristics
  has_many :characteristics, through: :item_characteristics
  has_many :cart_items
 
  validates :name, presence: true, length: { maximum: 100 }
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :active, inclusion: { in: [true, false] }
 end