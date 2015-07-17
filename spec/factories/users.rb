FactoryGirl.define do
  factory :user do
     sequence(:email, 100) { |n| "person#{n}@example.com" }
     password "chicasss"
     password_confirmation "chicasss"
  end
end
