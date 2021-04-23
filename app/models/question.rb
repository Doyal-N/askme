class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_question, dependent: :delete_all
  has_many :hashtags, dependent: :destroy, through: :hashtag_question

  validates :text, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }

  after_save :save_hashtags

  private

  def save_hashtags
    self.hashtags << find_patterns.map { |name| Hashtag.find_or_create_by(name: name) }
  end

  def find_patterns
    answer_tags =  answer&.scan(Hashtag::LINE) || []
    text.scan(Hashtag::LINE) | answer_tags
  end
end
