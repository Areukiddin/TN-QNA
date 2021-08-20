class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :answers, class_name: 'Answer', foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :questions, class_name: 'Question', foreign_key: :author_id, inverse_of: :author, dependent: :destroy

  def author_of?(resource)
    resource.author_id.eql?(id)
  end
end
