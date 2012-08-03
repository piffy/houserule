# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    event_id 1
    user_id 1
    pending "MyString"
    boolean "MyString"
    accepted false
    valid_until "MyString"
  end
end
