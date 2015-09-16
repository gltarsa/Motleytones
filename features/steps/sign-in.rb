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
    nav_li = find("li.navigation").hover
  end

  # admin
  step 'I navigate to the Add Pirate page' do
    nav_li = find("li.navigation").hover
    click_link "Add Pirate"
    sync_page
    expect(page.title).to eq("Add New Motley Tone")
  end

  step 'I navigate to the Users page' do
    nav_li = find("li.navigation").hover
    click_link "List Users"
    sync_page
    expect(page.title).to eq("Motley Users")
  end

  step 'I navigate to the Sign In page' do
    nav_li = find("li.navigation").hover
    i_click_sign_in
    expect(page.title).to eq("Sign In")
  end

  step 'I navigate to the Profile page' do
    nav_li = find("li.navigation").hover
    click_link "Profile"
    sync_page
    expect(page.title).to eq("Motley User")
  end

  # admin
  step 'I visit the Add Pirate page directly' do
    visit new_user_registration_path
  end

  step 'I visit the Users page directly' do
    visit users_path
  end

  step 'I visit the Add User page directly' do
    visit users_new_path
  end

  step 'I visit the Edit Profile page directly' do
    visit edit_user_registration_path
  end

  step 'I do not see a List Users link' do
    expect(page).to have_no_link("List Users")
  end

  step 'I do not see an Add User link' do
    expect(page).to have_no_link("Add User")
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

  step 'I see the page title containing "Motley User"' do
    expect(page.title).to match(/.*Motley User.*/)
  end

  step 'I see the page title containing "Motley User Profile"' do
    expect(page.title).to match(/Motley User Profile.*/)
  end

  step 'I click Edit' do
    # need test to see that the page is for the right user
    click_on "Edit Info"
    sync_page
  end

  step 'I click Edit for that other user' do
    click_on "Edit Info"
    sync_page
  end

  #admin
  step 'there is at least one other user' do
    i_navigate_to_the_add_pirate_page
    i_fill_in_the_fields
    i_click_sign_up
    expect(page.text).to have_content(@another_user.name)
  end

  #admin
  step 'I fill in the fields' do
    password = "secretpw"
    @another_user = FactoryGirl.build(:user)
    fill_in "user_name", with: @another_user.name
    fill_in "user_tone_name", with: @another_user.tone_name
    fill_in "user_email", with: @another_user.email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    check "user_admin"
  end

  #admin
  step 'I click Sign Up' do
    click_link "Sign up"
    sync_page
  end

  #admin
  step 'the account is created' do
    user = User.find_by(email: @another_user.email)
    expect(user).not_to be_nil
  end

  step 'I change the mutable fields' do
    fill_in "user_name", with: change(@user.name)
    fill_in "user_tone_name", with: change(@user.tone_name)
    fill_in "user_email", with: change(@user.email)
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
    expect(find(".user_name").text).to match("#{change(@user.name)}")
    expect(find(".user_tone_name").text).to match("#{change(@user.tone_name)}")
    expect(find(".user_email").text).to match("#{change(@user.email)}")
  end

  step 'the admin field is not changed' do
    if @old_admin_value
      expect(page).to have_css("p.user_admin")
    else
      expect(page).not_to have_css("p.user_admin")
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
    binding.pry
  end

  step 'I enter a registered email' do
    @password = "secretpw"
    @user = FactoryGirl.create(:user, password: @password)
    fill_in("user_email", with: @user.email)
  end

  step 'I enter the associated password' do
    fill_in("user_password", with: @password)
  end

  step 'I enter an unregistered email' do
    fill_in("user_email", with: "not_registered@user.com")
  end

  step 'I enter an invalid password' do
    fill_in("user_password", with: "incorrect-password")
  end

  private
    def has_flash_msg(severity: , containing: )
      all(".flash li").each do |msg|
        puts "flash message(s) seen: #{msg.text}"
      end

      #expect(page).to have_css(".flash .#{severity.to_s}")
      expect(page.find(".flash .#{severity.to_s}").text).to match(Regexp.new(".*#{containing}.*"))
    end

    def change(item)
      item + "changed"
    end

    def sync_page
      page.has_css?("nav")
    end
end
