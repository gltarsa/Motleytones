class Spinach::Features::SignIn < Spinach::FeatureSteps
  include Helpers

  step "I am signed in as a non-admin user" do
    sign_in_non_admin_user
  end

  step "I am signed in as an admin user" do
    sign_in_admin_user
  end

  step 'I am not signed in' do
    visit root_path
  end

  step 'I look at the Navigation menu' do
    find("li.navigation").hover
  end

  # admin
  step 'I navigate to the Add Pirate page' do
    find("li.navigation").hover
    click_link "Add Pirate"
    sync_page
    expect(page.title).to eq("Add New Pirate")
  end

  step 'I navigate to the Users page' do
    find("li.navigation").hover
    click_link "List Pirates"
    sync_page
    expect(page.title).to eq("Motley Users")
  end

  step 'I navigate to the Sign In page' do
    find("li.navigation").hover
    i_click_sign_in
    expect(page.title).to eq("Sign In")
  end

  step 'I navigate to the Profile page' do
    find("li.navigation").hover
    click_link "Profile"
    sync_page
    expect(page.title).to eq("Motley User")
  end

  # admin
  step 'I visit the Add Pirate page directly' do
    visit new_user_path
  end

  step 'I visit the Users page directly' do
    visit users_path
  end

  step 'I visit the Edit Profile page directly' do
    visit edit_user_path(1)  # any user id will work for this test
  end

  step 'I do not see a List Users link' do
    expect(page).to have_no_link("List Users")
  end

  step 'I do not see an Add Pirate link' do
    expect(page).to have_no_link("Add Pirate")
  end

  step 'I do not see a Profile link' do
    expect(page).to have_no_link("Profile")
  end

  step 'I do not see a Sign Out link' do
    expect(page).to have_no_link("Sign Out")
  end

  step 'I do not see an Edit button' do
    expect(page).to have_no_button("Edit")
  end

  step 'I do not see a Deactivate button' do
    expect(page).to have_no_button("Deactivate")
  end

  step 'I do not see a Delete button' do
    expect(page).to have_no_button("Delete")
  end

  step 'I am sent to the Profile page' do
    expect(page.title).to eq("Motley User")
  end

  step 'I am sent to the Change User Information page' do
    expect(page.title).to eq("Modify Pirate Profile")
  end

  step 'I am sent to the Profile page' do
    expect(page.title).to eq("Motley User")
    expect(page.text).to match(Regexp.new(".*#{@user.name}.*"))
  end

  step 'I am sent to the Sign In page' do
    expect(page.title).to eq("Sign In")
  end

  step 'I am sent to the root page' do
    expect(page.title).to eq("The Motley Tones")
  end

  step 'I see a success message containing "Signed in successfully"' do
    has_flash_msg(severity: :notice, containing: "Signed in successfully")
  end

  step 'I see an alert containing "You need to sign in or sign up before continuing"' do
    has_flash_msg(severity: :alert, containing: "You need to sign in or sign up before continuing.")
  end

  step 'I see an error containing "You must be an admin user to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be an admin user to access that page")
  end

  step 'I see an alert containing "Invalid email or password"' do
    has_flash_msg(severity: :alert, containing: "Invalid email or password")
  end

  step 'I see an alert containing "You cannot delete your own account"' do
    has_flash_msg(severity: :alert, containing: "You cannot delete your own account")
  end

  step 'I see an error notification' do
    expect(find(".error_notification").text).to match("problems below")
  end

  step 'I see the password is invalid' do
    binding.pry
    expect(find(".error").text).to match("is invalid")
  end

  step 'I see the new user name' do
    expect(page).to have_content(@user.name)
  end

  step 'I click Edit' do
    # need test to see that the page is for the right user
    click_on "Edit Info"
    sync_page
  end

  step 'I click Edit for that other user' do
    find(".user-id-#{@another_user.id} form.button_to .edit").click
    sync_page
  end

  step 'I click Delete and confirm deletion for that other user' do
    my_accept_alert do
      find(".user-id-#{@another_user.id} form.button_to .delete").click
    end
    sync_page
  end

  step 'that other user is deleted' do
    user = User.find_by(email: @another_user.email)
    expect(user).to be_nil
  end

  step 'the user is not deleted' do
    user = User.find_by(email: @user.email)
    expect(user).not_to be_nil
  end

  step 'there is at least one other user' do
    @another_user = FactoryGirl.create(:user)

    # i_navigate_to_the_add_pirate_page
    # i_fill_in_the_fields
    # i_click_sign_up
    # expect(page.text).to have_content(@another_user.name)
  end

  step 'I see information for another user' do
    expect(page.text).to have_content(@another_user.name)
  end

  step 'I fill in the fields' do
    @another_user = FactoryGirl.build(:user)
    fill_in "user_name", with: @another_user.name
    fill_in "user_tone_name", with: @another_user.tone_name
    fill_in "user_email", with: @another_user.email
    fill_in "user_password", with: PASSWORD
    fill_in "user_password_confirmation", with: PASSWORD
    check "user_admin"
  end

  step 'I click Sign Up' do
    click_link_or_button "Sign up"
    sync_page
  end

  step 'the account is created' do
    user = User.find_by(email: @another_user.email)
    expect(user).not_to be_nil
  end

  step 'I change the mutable fields' do
    fill_in "user_name", with: change(@user.name)
    fill_in "user_tone_name", with: change(@user.tone_name)
    fill_in "user_email", with: change(@user.email)
  end

  step 'I change the mutable fields for that other user' do
    fill_in "user_name", with: change(@another_user.name)
    fill_in "user_tone_name", with: change(@another_user.tone_name)
    fill_in "user_email", with: change(@another_user.email)
  end

  step 'I change the admin checkbox' do
    if @user.admin?
      @old_admin_value = true
      uncheck "user_admin"
    else
      @old_admin_value = false
      check "user_admin"
    end
  end

  step 'I click Update' do
    click_on "Update"
    sync_page
  end

  step 'the mutable fields are not changed' do
    expect(find(".user_name")).to have_content(@user.name)
    expect(find(".user_tone_name")).to have_content(@user.tone_name)
    expect(find(".user_email")).to have_content(@user.email)
  end

  step 'the mutable fields are changed' do
    expect_mutable_fields_to_be_changed(@user)
  end

  step 'the mutable fields for that other user are changed' do
    expect_mutable_fields_to_be_changed(@another_user)
  end

  step 'the admin field is not changed' do
    if @old_admin_value
      expect(page).to have_css("p.user_admin")
    else
      expect(page).not_to have_css("p.user_admin")
    end
  end

  step 'the admin field is changed' do
    id_class = ".user-id-#{@another_user.id}"
    if @old_admin_value
      expect(page).not_to have_css("p#{id_class}.user_admin")
    else
      expect(page).to have_css("p#{id_class}.user_admin")
    end
  end

  step 'I click Cancel' do
    click_on "Cancel"
    sync_page
  end

  step 'I click Sign In' do
    click_on "Sign in"
    sync_page
  end

  step 'I am still in the admin account' do
    find("li.navigation").hover
    expect(find("li.informational")).to have_content(@user.tone_name)
  end

  step 'I enter a registered email' do
    @user = FactoryGirl.create(:user, password: PASSWORD)
    fill_in("user_email", with: @user.email)
  end

  step 'I enter the associated password' do
    fill_in("user_password", with: PASSWORD)
  end

  step 'I enter an unregistered email' do
    fill_in("user_email", with: "not_registered@user.com")
  end

  step 'I enter an invalid password' do
    fill_in("user_password", with: "incorrect-password")
  end

  private

  def change(item)
    item + "changed"
  end

  def expect_mutable_fields_to_be_changed(user)
    id_class = ".user-id-#{user.id}"
    expect(find("#{id_class} .user_name").text).to match("#{change(user.name)}")
    expect(find("#{id_class} .user_tone_name").text).to match("#{change(user.tone_name)}")
    expect(find("#{id_class} .user_email").text).to match("#{change(user.email)}")
  end
end
