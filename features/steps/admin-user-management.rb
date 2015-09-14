class Spinach::Features::AdminUserManagement < Spinach::FeatureSteps
  include Helpers

  step "I am signed in as an admin user" do
    sign_in_admin_user
  end

  step 'I visit the Sign Up page' do
    visit new_user_registration_path
  end

  step 'I see the page title "Add New Motley Tone"' do
    expect(page.title).to eq("Add New Motley Tone")
  end

  step 'I see the user_name field' do
    pending 'step not implemented'
  end

  step 'I see the tone_name field' do
    pending 'step not implemented'
  end

  step 'I see the email field' do
    pending 'step not implemented'
  end

  step 'I see the password and password_confirmation fields' do
    pending 'step not implemented'
  end

  step 'I see the admin checkbox' do
    pending 'step not implemented'
  end

  step 'I fill in the fields' do
    pending 'step not implemented'
  end

  step 'I click Sign up' do
    pending 'step not implemented'
  end

  step 'the account is created' do
    pending 'step not implemented'
  end

  step 'I am still in the admin account' do
    pending 'step not implemented'
  end

  step 'there is at least one other user' do
    pending 'step not implemented'
  end

  step 'I visit the Users page' do
    visit users_path
  end

  step 'I see the page title "Motley Users"' do
    expect(page.title).to eq("Motley Users")
  end

  step 'I see information for another user' do
    pending 'step not implemented'
  end

  step 'I click the Delete button for that user' do
    pending 'step not implemented'
  end

  step 'I see an "Are you sure?" dialog box' do
    pending 'step not implemented'
  end

  step 'I click Yes' do
    pending 'step not implemented'
  end

  step 'the user is deleted' do
    pending 'step not implemented'
  end

  step 'I click the Deactivate button for that user' do
    pending 'step not implemented'
  end

  step 'the user is Deactivated' do
    pending 'step not implemented'
  end

  step 'I click the Edit button for that user' do
    pending 'step not implemented'
  end

  step 'I see the page title "Change User Information"' do
  expect(page.title).to eq("Change User Information")
  end

  step 'I see an Update button' do
    pending 'step not implemented'
  end

  step 'I change the user_name field' do
    pending 'step not implemented'
  end

  step 'I change the tone_name field' do
    pending 'step not implemented'
  end

  step 'I change the email field' do
    pending 'step not implemented'
  end

  step 'I change the admin checkbox' do
    pending 'step not implemented'
  end

  step 'I click the Update button' do
    pending 'step not implemented'
  end

  step 'the user fields are updated' do
    pending 'step not implemented'
  end
end
