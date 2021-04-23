class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }

  after_save :save_hashtags
  after_destroy :delete_old_tags

  private

  def save_hashtags
    self.hashtags = find_patterns.map { |name| Hashtag.find_or_create_by(name: name.downcase) }
  end

  def find_patterns
    answer_tags =  answer&.scan(Hashtag::LINE) || []
    text.scan(Hashtag::LINE) | answer_tags
  end

  def delete_old_tags
    Hashtag.left_outer_joins(:questions).where(questions: { id: nil }).destroy_all
  end
end
