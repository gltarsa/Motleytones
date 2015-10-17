module Helpers
  include Spinach::DSL
  #
  # Methods in this module provide shorthand, handy, or
  # semantic equivalents for operations performed
  # frequently in step.rb files.
  #
  # @user is available in the Spinach steps
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

  def sync_page
    page.has_css?("nav")
  end

  def has_flash_msg(severity: , containing: )
    expect(page.find(".flash .#{severity.to_s}").text).to match(Regexp.new(".*#{containing}.*"))
  end

  # Currently, poltergeist does not have the support for Capybara's accept_alert{}
  # this helper provides a workaround
  def my_accept_alert(&block)
    begin
      accept_alert { block.call }
    rescue Capybara::NotSupportedByDriverError
      block.call
    end
  end

  private

  def do_login(user, password)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: password
    click_button 'Sign in'
    sync_page
  end
end
