FactoryBot.define do
  factory :user do
    email { "MyString" }
    password { "MyText" }

    trait :invalid do
      email { nil }
    end
  end
end
