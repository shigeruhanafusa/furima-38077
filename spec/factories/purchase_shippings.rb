FactoryBot.define do
  factory :purchase_shipping do
    transient do
      person { Gimei.name }
      address { Gimei.address }
    end

    area_id               { 3 }
    postal_code           { "123-4567" }
    municpality           { address.city.kanji }
    address1              { address.town.kanji }
    address2              { "1-1-1" }
    phone                 { Faker::Number.number(digits: 10) }
  end
end
