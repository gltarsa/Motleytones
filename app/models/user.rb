# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save do
    self.email = email.downcase # ensure emails are saved in lower case
    self.name = name.titleize
    self.tone_name = tone_name.titleize
  end

  validates :name,
            presence: true,
            uniqueness: true,
            length: { minimum: 5, maximum: 50 }
  validates :tone_name,
            presence: true,
            length: { minimum: 7, maximum: 50 }
  validates :email, # max length per RFC 3696, errata ID 1690
            length: { maximum: 254 }
end
