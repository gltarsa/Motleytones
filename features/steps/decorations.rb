# frozen_string_literal: true

class Spinach::Features::Decorations < Spinach::FeatureSteps
  include Helpers

  step 'I am not signed in' do
    visit root_path
  end

  step 'I am signed in as an admin user' do
    sign_in_admin_user
  end

  step 'I look at the header of the home page' do
  end

  step 'I see a logo' do
    expect(page).to have_css("header h1.logo")
  end

  step 'I see a navigation menu' do
    expect(page).to have_css("nav li.navigation")
  end

  step 'I look at the footer of the home page' do
  end

  step 'I see a list of Friends Links' do
    expect(page).to have_css("footer .friend-list li")
  end

  step 'I see a copyright notice with the current year' do
    expect(page).to have_css("footer .copyright li", text: "© #{Date.current.year}")
  end

  step 'I see a visit counter' do
    expect(page).to have_css("footer li.visit-count")
  end

  step 'I see a contact widget' do
    expect(page).to have_css("footer section.widget.contact")
  end

  step 'I look at the contact widget on the home page' do
  end

  step 'I see a Facebook tile/image that links to the FB page' do
    expect(page).to have_css("section.widget.contact img.facebook-tile")
  end

  step 'I see a version number' do
    expect(page).to have_css("footer ul.version", text: "version:")
  end

  step 'I do not see a version number' do
    expect(page).not_to have_css("footer ul.version", text: "version:")
  end
end
