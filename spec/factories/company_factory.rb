FactoryBot.define do
  factory :company do
    name { Faker::Company.name }

    trait :with_employees do
      after(:create) do |company|
        create_list(:employee, 4, company: company)
      end
    end
  end
end
