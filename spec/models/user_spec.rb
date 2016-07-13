require 'rails_helper'
require 'devise'

RSpec.describe User, type: :model do
  let (:user) { FactoryGirl.create :user }

  describe "name" do
    it "is required" do
      user.name = " " * 10
      expect(user).not_to be_valid
    end

    it "must be at least 5 characters long" do
      user.name = "a" * 4
      expect(user).not_to be_valid
      user.name = user.name + "a"
      expect(user).to be_valid
    end

    it "must be less than 50 characters long" do
      user.name = "Long"
      user.name += "g" * (50 - user.name.length)
      expect(user).to be_valid
      user.name = user.name + "g"
      expect(user).not_to be_valid
    end

    it "must be unique" do
      user2 = FactoryGirl.build(:user, name: user.name)
      expect(user2).not_to be_valid
    end
  end

  describe "tone name" do
    it "is required" do
      user.tone_name = " "
      expect(user).not_to be_valid
    end

    it "must be at least 7 characters long" do
      user.tone_name = "123456"
      expect(user).not_to be_valid
      user.tone_name = user.tone_name + "7"
      expect(user).to be_valid
    end

    it "must be less than 50 characters long" do
      user.tone_name = "Long Tone"
      user.tone_name += "e" * (50 - user.tone_name.length)
      expect(user).to be_valid
      user.tone_name = user.tone_name + "e"
      expect(user).not_to be_valid
    end
  end

  describe "email" do
    # other email validations are done by devise and not tested here.
    # Devise ignores the max length requirement of RFC 3696, errata ID 1690
    # so there is an explicit length validation we added and are testing
    it "must be <= 254 characters" do
      suffix = ".com"
      user.email = "a@long"
      user.email += "g" * (255 - user.email.length - suffix.length)
      user.email += suffix
      expect(user).not_to be_valid
    end

    it "must be unique" do
      user2 = User.new(name: user.name, email: user.email)
      user.save
      expect(user2).not_to be_valid
    end

    it "uniqueness is case-insensitive" do
      user2 = User.new(name: user.name, email: user.email.upcase)
      user.save
      expect(user2).not_to be_valid
    end

    it "accepts addresses with proper format" do
      valid_addresses = %w[ user@example.com USER@foo.COM User+tag_string@foo.bar.net A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn ]
      valid_addresses.each do |addr|
        user.email = addr
        expect(user).to be_valid
      end
    end

    it "rejects email addresses with improper format" do
      invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. ]

      invalid_addresses.each do |addr|
        user.email = addr
        expect(user).not_to be_valid
      end
    end
  end

  describe "password" do
    it "must be present" do
      user.password  = user.password_confirmation = " " * 6
      expect(user).not_to be_valid
    end

    it "must be at least 8 characters long" do
      user.password = user.password_confirmation = "1234567"
      expect(user).not_to be_valid
      user.password = user.password_confirmation = user.password + "8"
      expect(user).to be_valid
    end
  end
end
