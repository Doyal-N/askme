class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :text, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }
end
