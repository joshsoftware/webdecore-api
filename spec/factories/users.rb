FactoryBot.define do
  factory :user do
    role
    first_name         { Faker::Name.first_name }
    last_name          { Faker::Name.last_name }
    contact_number     { Faker::PhoneNumber.phone_number }
    email              { Faker::Internet.email }
    password           { Faker::Number.number(digits: 7) }
  end
end