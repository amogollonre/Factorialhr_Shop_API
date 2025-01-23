class Category < ApplicationRecord
    has_many :items
    has_many :characteristics
    has_many :category_option_restrictions
  
    validates :name, presence: true, length: { maximum: 100 }
    validates :active, inclusion: { in: [true, false] }
  end