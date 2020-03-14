FactoryBot.define do
  factory :category do
    category_name         { Faker::Lorem.word }
    category_description  { Faker::Lorem.sentence(word_count: 10) }
    picture               { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/logo_image.jpg'), 'image/jpeg') }
  end
end
