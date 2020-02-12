FactoryBot.define do
  factory :role do
    role_name         { Faker::Name.first_name }
  end
end