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
    @user = FactoryBot.create(:user, password: SOME_PASSWORD)
    do_login(@user, SOME_PASSWORD)
  end

  def sign_in_admin_user
    @user = FactoryBot.create(:user, :admin, password: SOME_PASSWORD)
    do_login(@user, SOME_PASSWORD)
  end

  def expect_flash(severity:, containing:)
    expect(page).to have_css(".flash .#{severity}", text: containing)
  end

  def expect_form_error(containing: nil)
    expect(page).to have_css('.form-error', text: containing)
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
    "#{item[0]}changed#{item[1..-1]}"
  end

  # parse the text date into the three date fields used by simpleform_for
  def set_date(field_name, date)
    select(Date.parse(date).year, from: "#{field_name}_1i")
    select(Date::MONTHNAMES[Date.parse(date).month], from: "#{field_name}_2i")
    select(Date.parse(date).day, from: "#{field_name}_3i")
  end

  private

  def do_login(user, password)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end
end
