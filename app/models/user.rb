class User < ApplicationRecord
  has_many :questions, dependent: :destroy

  EMAIL_FORMAT = /[\w+.-]+@[\w.-]+/.freeze
  USERNAME_FORMAT = /\w/.freeze

  validates :username, :email, presence: true
  validates :username, length: { maximum: 40 }
  validates :username, :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: EMAIL_FORMAT, message: 'only email format' }
  validates :username, format: { with: USERNAME_FORMAT , message: 'only english letters, numbers and _' }

  before_save :normalize_username

  private

  def normalize_username
    self.username = username.downcase
  end
end
