class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :hashtags

  validates :text, length: { maximum: 255 }

  scope :sorted, -> { order(created_at: :desc) }

  before_save :save_hashtags

  private

  def save_hashtags
    find_patterns.each do |tag|
      hashtags = Hashtag.find_or_create_by(name: tag)
    end
    hashtags
  end

  def find_patterns
    tags_to_answer =  answer&.scan(Hashtag::LINE) || []
    text.scan(Hashtag::LINE) | tags_to_answer
  end
end
