FactoryBot.define do
  factory :cart do
    user_id { 1 }
    status { "pending" }
  end
end