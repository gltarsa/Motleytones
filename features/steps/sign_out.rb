# frozen_string_literal: true

class Spinach::Features::SignOut < Spinach::FeatureSteps
  include Helpers

  step "I am signed in as a non-admin user" do
    sign_in_non_admin_user
  end

  step 'I navigate to Sign Out' do
    find("li.navigation").click
    click_link_or_button "Sign Out"
    expect(page).to have_title("The Motley Tones")
  end

  step 'I see a success message containing "Signed out successfully"' do
    expect_flash(severity: :notice, containing: "Signed out successfully")
  end
end
