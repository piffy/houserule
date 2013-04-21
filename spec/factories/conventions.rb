# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :convention do
    sequence(:name) { |n| "Convention #{n}" }
    description {Faker::Lorem.sentence}
    location { Faker::Address.city }
    website_url "http://www.example.com"
    image_url "http://www.example.com/image.jpg"
    gcc "http://www.gcc.com"
    begin_date "2013-04-21 12:21:17"
    end_date "2013-04-21 12:21:17"
    association :user
  end
end
