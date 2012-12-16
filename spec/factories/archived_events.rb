# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :archived_event do
      sequence(:name) { |n| "Archived #{n}" }
      system  "System"
      begins_at "2013-11-13 18:56:50"
      duration "2h"
      description { Faker::Lorem.paragraph(2) }
      descr_short  { Faker::Lorem.sentence }
      aftermath  { Faker::Lorem.paragraph(2) }
      deadline "2013-10-13 18:56:50"
      location { Faker::Address.city }
      max_player_num 4
      min_player_num 1
      association :user
  end
end
