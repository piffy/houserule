# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    system  "System"
    begins_at "2013-11-13 18:56:50"
    duration "2h"
    description { Faker::Lorem.paragraph(2) }
    descr_short  { Faker::Lorem.sentence }
    deadline "2013-10-13 18:56:50"
    status 1
    location { Faker::Address.city }
    max_player_num 4
    min_player_num 1
    association :user

    factory :no_max_player_event do
      max_player_num 0
      min_player_num 0
    end

    factory :waiting_list_event do
      waiting_list 2
    end

  end

  factory :past_event do
    sequence(:name) { |n| "Past Event #{n}" }
    system  "System"
    begins_at "2012-05-11 18:56:50"
    duration "2h"
    description { Faker::Lorem.paragraph(2) }
    descr_short  { Faker::Lorem.sentence }
    deadline "2012-05-11 18:56:50"
    status 1
    location { Faker::Address.city }
    max_player_num 4
    min_player_num 1
    association :user
  end



end
