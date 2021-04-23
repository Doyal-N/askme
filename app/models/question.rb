class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :hashtags

  validates :text, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }

  before_save :save_hashtags

  private

  def save_hashtags
    self.hashtags << find_patterns.map { |name| Hashtag.create(name: name) }
  end

  def find_patterns
    answer_tags =  answer&.scan(Hashtag::LINE) || []
    text.scan(Hashtag::LINE) | answer_tags
  end
end
