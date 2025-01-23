FactoryBot.define do
  factory :category_option_restriction do
    category
    association :if_characteristic_option, factory: :characteristic_option
    association :then_characteristic_option, factory: :characteristic_option
    restriction_type { "incompatible" }
    active { true }
  end
end