FactoryBot.define do
  factory :item_form do
    product               { Faker::Commerce.brand }
    product_description   { Faker::Lorem.characters(number: 40, min_alpha: 1, min_numeric: 1) }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
    area_id               { 3 }
    category_id           { 3 }
    condition_id          { 3 }
    shipping_charge_id    { 3 }
    shipping_day_id       { 3 }
  end
end
