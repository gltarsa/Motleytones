require 'rails_helper'

describe "User#new page", type: :feature do
  before :each do
    @user = FactoryGirl.create(:admin)
  end

  it "has an page for adding a new band member" do
    visit "/users/sign_in"
    expect(page.title).to eq("Sign In")
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: PASSWORD)
    click_button "Sign in"
    visit "/users/new"
    expect(page.title).to eq("Add New Pirate")
  end
end

