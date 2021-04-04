require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest.new('SHA256')
  EMAIL_FORMAT = /\A\w+@\w+\.[a-z]+\z/.freeze
  USERNAME_FORMAT = /\A\w+\z/.freeze

  attr_accessor :password

  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :username, :email, presence: true
  validates :username, length: { maximum: 40 }
  validates :username, :email, uniqueness: true
  validates :email, format: { with: EMAIL_FORMAT }
  validates :username, format: { with: USERNAME_FORMAT }

  has_many :questions, dependent: :destroy

  before_validation :normalize_username
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil if user.blank?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  private

  def normalize_username
    self.username = username.downcase if username.present?
  end

  def encrypt_password
    return if password.blank?

    self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

    self.password_hash = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
  end
end
