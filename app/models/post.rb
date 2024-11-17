class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :comments, dependent: :destroy

  validates :description, presence: true
end
