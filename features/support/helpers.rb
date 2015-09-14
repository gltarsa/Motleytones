module Helpers
  include Spinach::DSL
  #
  # Methods in this module provide shorthand, handy, or
  # semantic equivalents for operations performed
  # frequently in step.rb files.
  #
  # PASSWORD = "secretpw"
  def sign_in_non_admin_user
    @user = FactoryGirl.create(:user, password: PASSWORD)
    do_login(@user, PASSWORD)
  end

  def sign_in_admin_user
    @user = FactoryGirl.create(:admin, password: PASSWORD)
    do_login(@user, PASSWORD)
  end

  private

  def do_login(user, password)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: password
    click_button 'Sign in'
    page.has_css?("li.navigation")
  end
end
