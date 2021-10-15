class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :rewards, dependent: :destroy

  has_many :answers, class_name: 'Answer', foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :questions, class_name: 'Question', foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :question_subscription
  has_many :subscribed_questions, through: :question_subscription, source: :question, dependent: :destroy
end
