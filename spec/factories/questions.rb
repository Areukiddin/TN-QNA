FactoryBot.define do
  sequence :title do |n|
    "Question #{n}"
  end

  sequence :body do |n|
    "Body of Question #{n}"
  end

  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    association :author, factory: :user

    factory :uniq_question do
      title
      body
      association :author, factory: :user
    end

    trait :invalid do
      title { nil }
    end
  end
end
