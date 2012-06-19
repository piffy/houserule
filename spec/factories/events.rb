# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    system "Strange System"
    begins_at "2012-05-13 18:56:50"
    duration "2h"
    description "MyString"
    descr_short "MyString"
    deadline "2012-05-13 18:56:50"
    status 1
    location "MyString"
    max_player_num 4
    min_player_num 1
    association :user
  end
end
