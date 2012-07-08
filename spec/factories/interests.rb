# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interest do
    association :group
    association :user
    is_visible true
    is_banned true
    gets_email false
  end
end
