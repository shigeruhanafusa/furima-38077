FactoryBot.define do
  factory :item do
    product               { Faker::Commerce.product_name }
    product_description   { Faker::Lorem.characters(number: 40, min_alpha: 1, min_numeric: 1) }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
    area                  { Area.last }
    category              { Category.last }
    condition             { Condition.last }
    shipping_charge       { ShippingCharge.last }
    shipping_day          { ShippingDay.last }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
