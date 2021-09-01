FactoryBot.define do
  factory :answer do
    body { 'MyAnswer' }
    question
    association :author, factory: :user

    factory :uniq_answer do
      sequence :body do |n|
        "Answer body #{n}"
      end
      question
      association :author, factory: :user
    end
  end

  trait :with_files do
    after(:build) do |answer|
      answer.files.attach(
        io: File.open(Rails.root.join('spec/rails_helper.rb')),
        filename: 'rails_helper.rb',
        content_type: '.rb'
      )
    end
  end

  trait :invalid do
    body { nil }
  end
end
