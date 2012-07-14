# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interest do
    association :group
    association :user
    is_visible true
    is_banned false
    gets_email false
  end
end
