class Reward < ApplicationRecord
  belongs_to :question, dependent: :destroy
  belongs_to :user, optional: true

  validates :title, :image, presence: true
end
