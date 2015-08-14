class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save { self.email = email.downcase } # ensure emails are saved in lower case

  validates :name, presence: true,
    length: { minimum: 5, maximum: 50 }
  validates :email, presence: true,
    length: { minimum: 6, maximum: 254 }, # max length per RFC 3696, errata ID 1690
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
    length: {minimum: 6, maximum: 72 } # password length constraints are arbitrary

  has_secure_password
end
