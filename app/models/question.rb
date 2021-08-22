class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :questions

  has_many :answers, -> { order(best: :desc) }, inverse_of: :question, dependent: :destroy

  validates :title, :body, presence: true
end
