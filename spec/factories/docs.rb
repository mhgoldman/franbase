FactoryGirl.define do
  factory :doc do
    content { Faker::Lorem.paragraphs(Random.rand(0..10)).join('<br/>') }
    name { Faker::Lorem.sentence(Random.rand(1..5)) }
    tags { Faker::Lorem.words(Random.rand(0..5)) }
    updater { create(:user) }
    creator { create(:user) }
  end
end