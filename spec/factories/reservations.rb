# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    association :user
    association :event
    status 1
  end
end
