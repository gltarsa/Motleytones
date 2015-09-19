require 'rails_helper'
require 'devise'

describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.create :user
  end

  describe "validation tests" do
    it "checks user and email validity" do
      expect(@user.valid?).to be true
    end

    it "fails if the user name is not present" do
      @user.name = " " * 10
      expect(@user.valid?).to be false
    end

    it "fails if the email is not present" do
      @user.email = " " * 10
      expect(@user.valid?).to be false
    end

    it "fails if the user name is < 5 characters" do
      @user.name = "a" * 4
      expect(@user.valid?).to be false
    end

    it "fails if the user name is > 50 characters" do
      @user.name = "Long"
      @user.name += "g" * (51 - @user.name.length)
      expect(@user.valid?).to be false
    end

    it "fails if the email is < 6 characters" do
      @user.email = "a@b.c"  # min internet email "a@b.cn"
      expect(@user.valid?).to be false
    end

    it "fails if the email is > 254 characters" do
      suffix = ".com"
      @user.email = "a@long"
      @user.email += "g" * (255 - @user.email.length - suffix.length)
      @user.email += suffix
      expect(@user.valid?).to be false
    end

    it "fails with an invalid email" do
      @user.email = "myemail#is.incorrect"
      expect(@user.valid?).to be false
    end

    it "fails if an email is not unique" do
      user2 = User.new(name: @user.name, email: @user.email)
      @user.save
      expect(user2.valid?).to be false
    end

    it "email uniqueness is case-insensitive" do
      user2 = User.new(name: @user.name, email: @user.email.upcase)
      @user.save
      expect(user2.valid?).to be false
    end

    describe "email format validation tests" do
      it "accepts email addresses with proper format" do
        valid_addresses = %w{ user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn }
        valid_addresses.each do |addr|
          @user.email = addr
          expect(@user.valid?).to be true
        end
      end

      it "rejects email addresses with proper format" do
        invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com ]

        invalid_addresses.each do |addr|
          @user.email = addr
          expect(@user.valid?).to be false
        end
      end
    end

    describe "password validation tests" do
      it "password must be present" do
        @user.password  = @user.password_confirmation = " " * 6
        expect(@user.valid?).to be false
      end

      it "password must be at least 6 characters long" do
        @user.password = @user.password_confirmation = "12345"
        expect(@user.valid?).to be false
      end
    end
  end
end
