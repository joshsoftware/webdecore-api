FactoryBot.define do
  factory :animation_data do
    category
    animation_name         { Faker::Name.first_name }
    animation_price        { Faker::Number.number(digits: 3) }
    picture                { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/logo_image.jpg'), 'image/jpeg') }
    animation_json         { Faker::Json.shallow_json(width: 3, options: { key: 'Name.first_name', value: 'Name.last_name' }) }
  end
end
