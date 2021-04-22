class Hashtag < ApplicationRecord
  has_and_belongs_to_many :questions

  validates :name, presence: true, length: { maximum: 20 }
end
