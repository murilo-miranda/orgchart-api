FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    company
  end
end
