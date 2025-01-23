class OptionImage < ApplicationRecord
  belongs_to :characteristic_option
 
  validates :url, presence: true, length: { maximum: 255 }
  validates :alt_text, length: { maximum: 255 }
  validates :display_order, uniqueness: { scope: :characteristic_option_id }
 end