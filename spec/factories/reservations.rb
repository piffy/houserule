# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    user_id 1
    event_id 1
    status 1
  end
end
