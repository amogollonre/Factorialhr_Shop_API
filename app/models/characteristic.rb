class Characteristic < ApplicationRecord
  belongs_to :category
  has_many :characteristic_options
  has_many :item_characteristics
  has_many :items, through: :item_characteristics
 
  validates :name, presence: true, length: { maximum: 100 }, 
            uniqueness: { scope: :category_id }
 end