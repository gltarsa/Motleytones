# frozen_string_literal: true
class Spinach::Features::SignOut < Spinach::FeatureSteps
  include Helpers

  step "I am signed in as a non-admin user" do
    sign_in_non_admin_user
  end

  step 'I navigate to Sign Out' do
    find("li.navigation").hover
    click_link_or_button "Sign Out"
    sync_page
    expect(page.title).to eq("The Motley Tones")
  end

  step 'I see a success message containing "Signed out successfully"' do
    has_flash_msg(severity: :notice, containing: "Signed out successfully")
  end
end
