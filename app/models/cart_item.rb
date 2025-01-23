class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
 
  validates :selected_options, presence: true
  validates :final_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
 end