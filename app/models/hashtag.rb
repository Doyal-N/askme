class Hashtag < ApplicationRecord
  LINE = /#[[:word:]]+/.freeze

  has_and_belongs_to_many :questions

  validates :name, presence: true, uniqueness: true, format: { with: LINE }, length: { maximum: 20 }

  before_validation :downcase_tag

  def downcase_tag
    name&.downcase!
  end
end
