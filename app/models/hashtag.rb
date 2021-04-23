class Hashtag < ApplicationRecord
  LINE = /#[[:word:]]+/.freeze

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  validates :name, presence: true, uniqueness: true, format: { with: LINE }, length: { maximum: 20 }

  before_validation :downcase_tag

  def downcase_tag
    name&.downcase!
  end
end
