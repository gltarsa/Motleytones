class Spinach::Features::SignIn < Spinach::FeatureSteps
  include Helpers

  step 'I am not signed in' do
    visit root_path
  end

  step 'I navigate to the Sign In page' do
    find("li.navigation").hover
    i_click_sign_in
    expect(page.title).to eq("Sign In")
  end

  step 'I am sent to the Profile page' do
    expect(page.title).to eq("Motley User")
    expect(page.text).to match(/.*#{@user.name}.*/i)
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
    sync_page
  end

  step 'I see a success message containing "Signed in successfully"' do
    has_flash_msg(severity: :notice, containing: "Signed in successfully")
  end

  step 'I see an alert containing "Invalid email or password"' do
    has_flash_msg(severity: :alert, containing: "Invalid email or password")
  end

  step 'I see the new user name' do
    expect(page).to have_content(@user.name)
  end
end
