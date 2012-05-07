FactoryGirl.define do
  factory :user do
    name     "Paperino"
    email    "donald@disney.com"
    password "password"
    remember_token "ABCDREFGHILM"
  end
end