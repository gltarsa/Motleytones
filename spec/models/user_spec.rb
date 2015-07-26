require 'rails_helper'

describe User, type: :model do
  before(:each) do
    @user = User.new do |u|
      u.name = "Test Man1"
      u.email = "good@email.com"
    end
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

    it "fails with an invalid email" do
      @user.email = "myemail#is.incorrect"
      expect(@user.valid?).to be false
    end

    it "fails if an email is not unique" do
      user2 = User.new(name: @user.name, email: @user.email)
      @user.save
      expect(user2.valid?).to be false
    end

    it "tests email uniqueness in a case-insensitive manner" do
      user2 = User.new(name: @user.name, email: @user.email.upcase)
      @user.save
      expect(user2.valid?).to be false
    end
  end
end
