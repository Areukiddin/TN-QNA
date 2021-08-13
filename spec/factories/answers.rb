FactoryBot.define do
  sequence :body_answer do |n|
    "Answer body #{n}"
  end

  factory :answer do
    body { 'MyText' }
    association :question
    association :author, factory: :user

    factory :uniq_answer do
      body
      association :question
      association :author, factory: :user
    end

    trait :invalid do
      body { nil }
    end
  end
end
