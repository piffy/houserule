# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    #sequence(:description) { |n| "A description" }
    description {Faker::Lorem.sentence}
    location { Faker::Address.city }
    website_url  { "http://"+Faker::Internet.domain_name }
    image_url { "http://"+Faker::Internet.domain_name+"/image.jpg" }
    association :user
  end
end
