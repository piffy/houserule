# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name {  Faker::Name.first_name }
    description description {Faker::Lorem.sentence}
    user_id 1
    location { Faker::Address.city }
    website_url  { "http://"+Faker::Internet.domain_name }
    image_url { "http://"+Faker::Internet.domain_name+"/image.jpg" }
  end
end
