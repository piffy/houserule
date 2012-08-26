FactoryGirl.define do
  Faker::Config.locale = :it

  factory :user do
    name {  Faker::Name.name }
    email  { Faker::Internet.email }
    location { Faker::Address.city }
    description {Faker::Lorem.sentence(2)}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end