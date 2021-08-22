FactoryBot.define do
  sequence :title do |n|
    "Question #{n}"
  end

  sequence :body do |n|
    "Body of Question #{n}"
  end

  factory :question do
    title { 'MyString' }
    body { 'MyQuestion' }
    association :author, factory: :user

    factory :uniq_question do
      title
      body
    end
  end

  trait :with_answers do
    transient { answers_count { 3 } }

    after(:create) { |question, evaluator| create_list(:uniq_answer, evaluator.answers_count, question: question, author: question.author) }
  end

  trait :invalid_question do
    title { nil }
  end
end
