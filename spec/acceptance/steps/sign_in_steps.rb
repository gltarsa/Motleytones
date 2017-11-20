# frozen_string_literal: true
require 'spec_helper'

module SignInSteps
  include Turnip::StepHelpers

  step 'I am not signed in' do
    visit root_path
  end

  step 'I navigate to the Sign In page' do
    binding.pry
    find("li.navigation").hover
    i_click_sign_in
    expect(page).to have_title("Sign In")
  end

  step 'I am sent to the Profile page' do
    expect(page).to have_title("Motley User")
    expect(page).to have_content(@user.name)
  end

  step 'I enter a registered email' do
    @user = FactoryGirl.create(:user, password: SOME_PASSWORD)
    fill_in("user_email", with: @user.email)
  end

  step 'I enter the associated password' do
    fill_in("user_password", with: SOME_PASSWORD)
  end

  step 'I enter an unregistered email' do
    fill_in("user_email", with: "not_registered@user.com")
  end

  step 'I enter an invalid password' do
    fill_in("user_password", with: "incorrect-password")
  end

  step 'I click Sign In' do
    click_on "Sign in"
  end

  step 'I see a success message containing "Signed in successfully"' do
    expect_flash(severity: :notice, containing: "Signed in successfully")
  end

  step 'I see an alert containing "Invalid Email or password"' do
    expect_flash(severity: :alert, containing: "Invalid Email or password")
  end

  step 'I see the new user name' do
    expect(page).to have_content(@user.name)
  end
end

RSpec.configure { |config| config.include SignInSteps }

