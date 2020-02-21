FactoryBot.define do
  factory :category do
    category_name         { Faker::Name.first_name }
    category_description  { Faker::Name.first_name }
    picture               { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/logo_image.jpg'), 'image/jpeg') }
  end
end
