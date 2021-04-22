class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :hashtags

  validates :text, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }
end
