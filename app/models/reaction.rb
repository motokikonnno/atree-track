class Reaction < ApplicationRecord
  validates :body, presence: true, length: { maximum: 140 }
  belongs_to :user
  belongs_to :answer
  has_many :notifications, dependent: :destroy
end
