FactoryGirl.define do
  factory :user do
     sequence(:email, 100) { |n| "person#{n}@example.com" }
     sequence(:first_name, 100) { |n| "Person#{n}" }
     last_name "Smith"
     password "chicasss"
     password_confirmation "chicasss"
  end
end
