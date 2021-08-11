FactoryBot.define do
  sequence :title do |n|
    "Question #{n}"
  end

  sequence :body do |n|
    "Body of Question #{n}"
  end

  factory :question do
    title { "MyString" }
    body { "MyText" }

    factory :uniq_question do
      title
      body
    end

    trait :invalid do
      title { nil }
    end
  end
end
