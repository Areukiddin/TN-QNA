class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User', inverse_of: :answers

  has_many_attached :files

  validates :body, presence: true

  def assign_as_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
