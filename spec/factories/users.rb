FactoryBot.define do
  factory :user do
    first_name         { Faker::Name.first_name }
    last_name          { Faker::Name.last_name }
    role               { Faker::Name.first_name }
    contact_number     { Faker::Number.number(digits: 10) }
    email              { Faker::Internet.email }
    password           { Faker::Number.number(digits: 7) }
  end
end
