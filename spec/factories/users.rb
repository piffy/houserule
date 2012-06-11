FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| Faker::Name.name }
    sequence(:email) { |n| Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      name     "Admin"
      email    "admin@disney.com"
    end
  end
end