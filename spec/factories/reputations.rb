# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.sequence :random do
  rand(10)
end

FactoryGirl.define do
  sequence(:random10) { rand(10) }
  factory :reputation do
    association :user
    participations { Factory.next(:random10) }
    positive_fb { Factory.next(:random10) }
    negative_fb { Factory.next(:random10) }
  end
end
