class Hashtag < ApplicationRecord
  LINE = /#[[:word:]]+/.freeze

  has_many :hashtag_question, dependent: :delete_all
  has_many :questions, dependent: :destroy, through: :hashtag_question

  validates :name, presence: true, uniqueness: true, format: { with: LINE }, length: { maximum: 20 }

  before_validation :downcase_tag

  def downcase_tag
    name&.downcase!
  end
end
