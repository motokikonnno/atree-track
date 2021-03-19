class Answer < ApplicationRecord
    validates :content, presence: true, length: { maximum: 140 }
    belongs_to :user
    belongs_to :post
    has_many :reactions, dependent: :destroy
    has_many :notifications, dependent: :destroy
end