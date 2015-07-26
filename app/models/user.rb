class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true,
    length: { minimum: 5, maximum: 50 }
  validates :email, presence: true,
    length: { minimum: 6, maximum: 254 }, # max length per RFC 3696, errata ID 1690
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
end
