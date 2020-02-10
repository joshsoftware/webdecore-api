FactoryBot.define do
  factory :user_animation do
    user
    animation_data
    start_date         { Faker::Date.between(from: Date.today, to: 365.days.from_now) } 
    end_date           { Faker::Date.between(from: Date.today, to: 365.days.from_now) }
    location           { Faker::Address.state }
  end
end