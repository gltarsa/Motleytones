class Spinach::Features::DeactivateAccount < Spinach::FeatureSteps
  include Helpers

  step "I am signed in as a non-admin user" do
    sign_in_non_admin_user
  end

  step "I am signed in as an admin user" do
    sign_in_admin_user
  end

  step 'I navigate to the Profile page' do
    find("li.navigation").hover
    click_link "Profile"
    sync_page
    expect(page.title).to eq("Motley User")
  end

  step 'I click Deactivate and confirm deactivation for that user' do
    pending "Not yet implemented"
    # the code below will work for this step, but the button is not implemented yet.
    accept_alert do
      find(".user-information form.button_to .delete").click
    end
    sync_page
  end
  step "that user is deactivated" do
    pending "Not yet implemented"
  end
end


