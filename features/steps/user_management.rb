# frozen_string_literal: true
class Spinach::Features::UserManagement < Spinach::FeatureSteps
  include Helpers

  step 'I am not signed in' do
    visit root_path
  end

  step 'I am signed in as a non-admin user' do
    sign_in_non_admin_user
  end

  step 'I am signed in as an admin user' do
    sign_in_admin_user
  end

  step 'I look at the Navigation menu' do
    find('li.navigation').hover
  end

  step 'I navigate to the Add Pirate page' do
    find('li.navigation').hover
    click_link 'Add Pirate'
    sync_page
    expect(page.title).to eq('Add Pirate')
  end

  step 'I navigate to the Manage Pirates page' do
    find('li.navigation').hover
    click_link 'Manage Pirates'
    sync_page
    expect(page.title).to eq('Motley Users')
  end

  step 'I navigate to the Profile page' do
    find('li.navigation').hover
    click_link 'Profile'
    sync_page
    expect(page.title).to eq('Motley User')
  end

  step 'I visit the Add Pirate page directly' do
    visit new_user_path
  end

  step 'I visit the Manage Pirates page directly' do
    visit users_path
  end

  step 'I visit the Edit Profile page directly' do
    visit edit_user_path(1) # any user id will work for this test
  end

  step 'I do not see a Manage Pirates link' do
    expect(page).to have_no_link('Manage Pirates')
  end

  step 'I do not see an Add Pirate link' do
    expect(page).to have_no_link('Add pirate')
  end

  step 'I do not see a Profile link' do
    expect(page).to have_no_link('Profile')
  end

  step 'I do not see a Sign Out link' do
    expect(page).to have_no_link('Sign Out')
  end

  step 'I do not see a Delete button' do
    expect(page).to have_no_button('Delete')
  end

  step 'I am sent to the Change Pirate Information page' do
    expect(page.title).to eq('Modify Pirate Profile')
  end

  step 'I am sent to the Profile page' do
    expect(page.title).to eq('Motley User')
    expect(page.text).to match(/.*#{@user.name}.*/i)
  end

  step 'I am sent to the Root page' do
    expect(page.title).to eq('The Motley Tones')
  end

  step 'I am sent to the Sign In page' do
    expect(page.title).to eq('Sign In')
  end

  step 'I see a success message containing "Signed in successfully"' do
    expect_flash(severity: :notice, containing: 'Signed in successfully')
  end

  step 'I see an alert containing "You must be signed in to access that page"' do
    expect_flash(severity: :alert, containing: 'You must be signed in to access that page')
  end

  step 'I see an alert containing "You must be an admin user to access that page"' do
    expect_flash(severity: :alert, containing: 'You must be an admin user to access that page')
  end

  step 'I see an alert containing "Invalid email or password"' do
    expect_flash(severity: :alert, containing: 'Invalid email or password')
  end

  step 'I see an error message' do
    expect_form_error
  end

  step 'I see the new user name' do
    expect(page).to have_content(@user.name)
  end

  step 'I click Edit' do
    # need test to see that the page is for the right user
    click_on 'Edit Pirate'
    sync_page
  end

  step 'I click Edit for that other user' do
    user_article(@another_user).click_on 'Edit'
    sync_page
  end

  step 'I click Delete and confirm deletion for that other user' do
    my_accept_alert do
      user_article(@another_user).find('.delete').click
    end
    sync_page
  end

  step 'that other user is deleted' do
    user = User.find_by(email: @another_user.email)
    expect(user).to be_nil
  end

  step 'there is at least one other user' do
    @another_user = FactoryGirl.create(:user)
  end

  step 'I see information for another user' do
    expect(page.text).to have_content(@another_user.name)
  end

  step 'I see that the Band Start Date is not the first of this year' do
    date_fields = { "1i" => "2010",
                    "2i" => "1",
                    "3i" => "1" }
    within "form#edit_user_#{@another_user.id}" do
      date_fields.each do |tag, value|
        expect(find("#user_band_start_date_#{tag}").value).to match(value)
      end
    end
  end

  step 'I fill in the fields' do
    @band_start_date = '9-Jul-2010'
    @another_user = FactoryGirl.build(:user)
    fill_in 'user_name', with: @another_user.name
    fill_in 'user_tone_name', with: @another_user.tone_name
    set_date('user_band_start_date', @band_start_date)
    fill_in 'user_email', with: @another_user.email
    fill_in 'user_password', with: SOME_PASSWORD
    fill_in 'user_password_confirmation', with: SOME_PASSWORD
    check 'user_admin'
  end

  step 'I fill in the fields to have the same name as the other user' do
    i_fill_in_the_fields
    fill_in 'user_name', with: @user.name
  end

  step 'I click Add Pirate' do
    click_link_or_button 'Add pirate'
    sync_page
  end

  step 'I click Add' do
    click_link_or_button 'Add'
    sync_page
  end

  step 'the account is created' do
    user = User.find_by(email: @another_user.email)
    expect(user).not_to be_nil
  end

  step 'I change the mutable fields' do
    change_mutable_fields(@user)
  end

  step 'I change my password' do
    new_password = 'newpasssword'
    fill_in 'user_password', with: new_password
    fill_in 'user_password_confirmation', with: new_password
  end

  step 'I change the mutable fields for that other user' do
    change_mutable_fields(@another_user)
  end

  step 'I change the admin checkbox' do
    if @user.admin?
      @old_admin_value = true
      uncheck 'user_admin'
    else
      @old_admin_value = false
      check 'user_admin'
    end
  end

  step 'I click Update' do
    click_on 'Update'
    sync_page
  end

  step 'the mutable fields are not changed' do
    expect_mutable_fields_not_to_be_changed(@user)
  end

  step 'the mutable fields are changed' do
    expect_mutable_fields_to_be_changed(@user)
  end

  step 'I see my name on the users page' do
    expect(find('.user_name').text).to match(@user.name)
  end

  step 'the mutable fields for that other user are changed' do
    expect_mutable_fields_to_be_changed(@another_user)
  end

  step 'the admin field is not changed' do
    if @old_admin_value
      expect(page).to have_css('p.user_admin')
    else
      expect(page).not_to have_css('p.user_admin')
    end
  end

  step 'the admin field is changed' do
    within user_article(@another_user) do
      if @old_admin_value
        expect(page).not_to have_css('p.user_admin')
      else
        expect(page).to have_css('p.user_admin')
      end
    end
  end

  step 'I click Cancel' do
    click_on 'Cancel'
    sync_page
  end

  step 'I click Sign In' do
    click_on 'Sign in'
    sync_page
  end

  step 'I am still in the admin account' do
    find('li.navigation').hover
    expect(find('li.informational')).to have_content(@user.tone_name)
  end

  private

  def user_article(user)
    find("article.user-id-#{user.id}")
  end

  # support for unit testy way to check for attribute changes
  def raw_mutable_attributes(user)
    user.attributes.slice('name', 'tone_name', 'email', 'user_start_date')
  end

  def change_mutable_fields(user)
    @changed_date = "1-Apr-#{Date.today.year + 1}" # app always allows one year more than today
    @original_raw_mutable_attributes = raw_mutable_attributes(user)
    fill_in 'user_name',       with: change(user.name)
    fill_in 'user_tone_name',  with: change(user.tone_name)
    fill_in 'user_email',      with: change(user.email)
    set_date('user_band_start_date', @changed_date)
  end

  def expect_mutable_fields_to_be_changed(user) # rubocop: disable AbcSize
    within user_article(user) do
      expect(find('.user_name').text).to       match(change(user.name))
      expect(find('.user_tone_name').text).to  match(change(user.tone_name))
      expect(find('.user_email').text).to      match(change(user.email))
      expect(find('.user_start_date').text).to match(@changed_date)
    end
    # unit testy way to check attribute changes
    expect(raw_mutable_attributes(User.find(user.id))).not_to eql(@original_raw_mutable_attributes)
  end

  def expect_mutable_fields_not_to_be_changed(user) # rubocop: disable AbcSize
    within user_article(user) do
      expect(find('.user_name').text).to       match(user.name)
      expect(find('.user_tone_name').text).to  match(user.tone_name)
      expect(find('.user_email').text).to      match(user.email)
      expect(find('.user_start_date').text).to match(user.band_start_date.strftime('%d-%b-%Y'))
    end
    # unit testy way to check attribute constancy
    expect(raw_mutable_attributes(User.find(user.id))).to eql(@original_raw_mutable_attributes)
  end
end
