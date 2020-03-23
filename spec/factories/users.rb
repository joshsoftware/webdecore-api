FactoryBot.define do
  factory :user do
    first_name         { Faker::Name.first_name }
    last_name          { Faker::Name.last_name }
    role               { 'user' }
    contact_number     { 8446262628 }
    email              { Faker::Internet.unique.email }
    password           { Faker::Internet.password(min_length: 6) }
    uuid               { Faker::Alphanumeric.alpha(number: 10) }
  end
end
