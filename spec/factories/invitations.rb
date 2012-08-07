# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    association :user
    association :event
    accepted false
    valid_until "2013-11-13 18:56:50"
  end
end
