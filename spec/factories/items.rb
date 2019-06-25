FactoryBot.define do
  factory :item do
    name { "Thing" }
    description { "Doohickey" }
    unit_price { 1 }
    merchant_id { 1 }
  end
end
