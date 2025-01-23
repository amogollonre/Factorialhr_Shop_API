FactoryBot.define do
  factory :characteristic_option do
    characteristic
    sequence(:name) { |n| "Option #{n}" }
    price_adjustment { 0.0 }
    in_stock { true }
  end
end