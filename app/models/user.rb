class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save {
    self.email = email.downcase # ensure emails are saved in lower case
    self.name = name.titleize
    self.tone_name = tone_name.titleize
  }

  validates :name, presence: true,
    length: { minimum: 5, maximum: 50 }
  validates :tone_name, presence: true,
    length: { minimum: 7, maximum: 50 }
  validates :email, presence: true,
    length: { minimum: 6, maximum: 254 }, # max length per RFC 3696, errata ID 1690
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
end
