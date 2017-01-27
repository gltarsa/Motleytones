# frozen_string_literal: true
module Helpers
  include Spinach::DSL
  #
  # Methods in this module provide shorthand, handy, or
  # semantic equivalents for operations performed
  # frequently in step.rb files.
  #
  # @user is available in the Spinach steps
  #
  def sign_in_non_admin_user
    @user = FactoryGirl.create(:user, password: SOME_PASSWORD)
    do_login(@user, SOME_PASSWORD)
  end

  def sign_in_admin_user
    @user = FactoryGirl.create(:user, :admin, password: SOME_PASSWORD)
    do_login(@user, SOME_PASSWORD)
  end

  def sync_page
    page.has_css?("nav")
  end

  def expect_flash(severity:, containing:)
    expect(page.find(".flash .#{severity}").text).to match(/.*#{containing}.*/i)
  end

  def expect_form_error(containing: nil)
    expect(page.find(".form-error").text).to match(/.*#{containing}.*/i)
  end

  # Currently, poltergeist does not have the support for Capybara's accept_alert{}
  # this helper provides a workaround
  def my_accept_alert
    accept_alert { yield }
  rescue Capybara::NotSupportedByDriverError
    yield
  end

  # standard "change" for tests
  def change(item)
    item[0] + "changed" + item[1..-1]
  end

  # parse the text date into the three date fields used by simpleform_for
  def set_date(field_name, date)
    find("##{field_name}_1i").select(Date.parse(date).year)
    find("##{field_name}_2i").select(Date::MONTHNAMES[Date.parse(date).month])
    find("##{field_name}_3i").select(Date.parse(date).day)
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
