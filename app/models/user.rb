class User < ApplicationRecord
  enum sex: %i(male female).freeze

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
    length: {maximum: Settings.name.maximum}
  validates :email, presence: true,
    length: {maximum: Settings.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password.minimum}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
