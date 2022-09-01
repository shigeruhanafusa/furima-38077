FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    name                  { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    birth_date            { Faker::Date.birthday(min_age: 18, max_age: 65) }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_kana        { person.last.katakana }
    first_name_kana       { person.first.katakana }
  end
end