FactoryGirl.define do
  factory :user do
    name     "Paperino"
    email    "donald@disney.com"
    password "password"
    password_confirmation "password"
    remember_token "ABCDREFGHILM"

    factory :admin do
      name     "Admin"
      email    "admin@disney.com"
    end
  end
end