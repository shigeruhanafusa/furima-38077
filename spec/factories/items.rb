FactoryBot.define do
  factory :item do
    product               { Faker::Commerce.product_name }
    product_description   { Faker::Lorem.characters(number: 40, min_alpha: 1, min_numeric: 1) }
    price                 { Faker::Number.between(from: 300, to: 9999999) }
    area_id               { Area.find :all, '---' }
    category_id           { Category.find :all, '---' }
    condition_id          { Condition.find :all, '---' }
    shipping_charge_id    { ShippingCharuge.find :all, '---' }
    shipping_day_id       { ShippingDay.find :all, '---' }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end