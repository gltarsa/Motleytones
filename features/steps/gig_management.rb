# frozen_string_literal: true

class Spinach::Features::GigManagement < Spinach::FeatureSteps
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

  step 'I navigate to the Manage Gigs page' do
    find('li.navigation').hover
    click_link 'Manage Gigs'
    i_am_on_the_manage_gigs_page
  end

  step 'I am on the Manage Gigs page' do
    expect(page).to have_title('Manage Gigs')
  end

  step 'I see the Add Gig page' do
    expect(page).to have_title('Add Gig')
  end

  step 'I see a note describing tokens' do
    expect(page).to have_css('p.note', text: 'tokens')
  end

  step 'I fill in the gig fields' do
    @gig = FactoryBot.build(:gig)
    set_date('gig_date',    @gig.date.to_s)
    fill_in 'gig_name',     with: @gig.name
    fill_in 'gig_note',     with: @gig.note
    fill_in 'gig_location', with: @gig.location
    check 'gig_published'
  end

  step 'I fill in the gig fields to have the same name and date' do
    set_date 'gig_date',    @gig.date.to_s
    fill_in 'gig_name',     with: @gig.name
    fill_in 'gig_note',     with: 'does not matter'
    fill_in 'gig_location', with: 'does not matter'
    check 'gig_published'
  end

  step 'I click Add Gig' do
    click_link_or_button 'Add gig'
  end

  step 'I click Manage Gigs' do
    click_link 'Manage gigs'
  end

  step 'the gig is created' do
    @gig = Gig.find_by(name: @gig.name)
    expect(@gig).not_to be_nil
  end

  step 'I see information for a gig' do
    @gig = Gig.where(name: @gig.name).where(location: @gig.location).first
    verify_gig_schedule(@gig)
  end

  step 'I see information for the unpublished gig' do
    gig = Gig.where(name: @unpublished_gig.name).where(location: @unpublished_gig.location).first
    verify_gig_schedule(gig)
  end

  step 'I do not see information for the unpublished gig' do
    gig = Gig.where(name: @unpublished_gig.name).where(location: @unpublished_gig.location).first
    expect(page).not_to have_css(".gig-id-#{gig.id}")
  end

  step 'I see information for the published gig' do
    i_see_information_for_a_gig
  end

  step 'I see information for the gig on the home page' do
    visit root_path
    i_see_information_for_a_gig
  end

  step 'I see information for the gig on the schedule page' do
    visit '/schedule'
    verify_gig_schedule(@gig)
  end

  step 'I navigate to the Performance Schedule page' do
    find('li.navigation').hover
    click_link 'Performance Schedule'
    expect(page.title).to eq('Motley Performance Schedule')
  end

  step 'I click Delete and confirm deletion for that gig' do
    my_accept_alert do
      find(".gig-id-#{@gig.id}").click_link('Delete')
    end
  end

  step 'that gig is deleted' do
    expect(Gig.find_by(id: @gig.id)).to be_nil
  end

  step 'I click Edit for the first gig' do
    find(".gig-id-#{@gig.id}").click_link('Edit')
  end

  step 'I click Edit for the new gig' do
    find(".gig-id-#{@new_gig.id}").click_link('Edit')
  end

  step 'I am sent to the Change Gig page' do
    expect(page).to have_title('Modify Gig Info')
  end

  step 'I am sent to the Sign In page' do
    expect(page.title).to eq('Sign In')
  end

  step 'I am sent to the Home page' do
    expect(page.title).to eq('The Motley Tones')
  end

  step 'I change the gig fields' do
    @changed_date = '9-Aug-2015'
    fill_in  'gig_name',     with: change(@gig.name)
    fill_in  'gig_note',     with: change(@gig.note)
    set_date 'gig_date',     @changed_date
    fill_in  'gig_location', with: change(@gig.location)
  end

  step 'I click Update' do
    click_on 'Update'
  end

  step 'the gig fields are changed' do
    within find(".gig-id-#{@gig.id}") do
      expect(page).to have_css('span.gig-name', text: change(@gig.name))
      expect(page).to have_css('span.gig-note', text: change(@gig.note))
      expect(page).to have_css('span.gig-date', text: Date.parse(@changed_date).strftime('%b %-d:'))
      expect(page).to have_css('span.gig-location', text: change(@gig.location))
    end
  end

  step 'there is at least one published gig' do
    @gig = FactoryBot.create(:gig, published: true)
  end

  step 'there is at least one published one-day gig dated yesterday' do
    @gig = FactoryBot.create(:gig, published: true, days: 1, date: Time.zone.yesterday)
  end

  step 'there is at least one published two-day gig dated yesterday' do
    @gig = FactoryBot.create(:gig, published: true, days: 2, date: Time.zone.yesterday)
  end

  step 'there is at least one published two-day gig dated two days ago' do
    @gig = FactoryBot.create(:gig, published: true, days: 2, date: Time.zone.today - 2)
  end

  step 'there is at least one published two-day gig dated three days ago' do
    @gig = FactoryBot.create(:gig, published: true, days: 2, date: Time.zone.today - 3)
  end

  step 'there is at least one published one-day gig dated two days ago' do
    @gig = FactoryBot.create(:gig, published: true, days: 1, date: Time.zone.today - 2)
  end

  step 'there is at least one existing gig' do
    @gig = FactoryBot.create(:gig)
  end

  step 'I add a new gig' do
    @new_gig = FactoryBot.create(:gig)
  end

  step 'there is at least one unpublished gig' do
    @unpublished_gig = FactoryBot.create(:gig, published: false)
  end

  step 'there is at least one unpublished one-day gig dated two days ago' do
    @unpublished_gig = FactoryBot.create(:gig,
                                          published: false,
                                          days: 1,
                                          date: Time.zone.today - 2)
  end

  step 'I see the published gig is expired' do
    i_see_information_for_a_gig
    verify_gig_expired(@gig)
  end

  step 'I see the published gig is active' do
    i_see_information_for_a_gig
    verify_gig_active(@gig)
  end

  step 'I see the unpublished gig is expired' do
    gig = Gig.where(name: @unpublished_gig.name).where(location: @unpublished_gig.location).first
    verify_gig_schedule(gig)
    verify_gig_expired(gig)
  end

  step 'I do not see a Manage Gigs link' do
    expect(page).to have_no_link('Manage Gigs')
  end

  step 'I do not see an Edit button' do
    expect(page).not_to have_button('Edit')
  end

  step 'I do not see a Delete button' do
    expect(page).not_to have_button('Delete')
  end

  step 'I see an alert containing "You must be signed in to access that page"' do
    expect_flash(severity: :alert, containing: I18n.t('devise.failure.unauthenticated'))
  end

  step 'I see an alert containing "You must be an admin user to access that page"' do
    expect_flash(severity: :alert, containing: I18n.t('.must_be_admin'))
  end

  step 'I see an error message' do
    expect_form_error
  end

  step 'I visit the Gig Management page directly' do
    visit gigs_path
  end

  step 'I visit the Add Gig page directly' do
    visit new_gig_path
  end

  step 'I visit the Edit Gig page directly' do
    visit edit_gig_path(1) # any user id will work for this test
  end

  step 'I change the published checkbox' do
    if @gig.published?
      @orig_published_value = true
      uncheck 'gig_published'
    else
      @orig_admin_value = false
      check 'gig_published'
    end
  end

  step 'the published field is changed' do
    within find(".gig-id-#{@gig.id}") do
      if @orig_published_value
        expect(page).not_to have_css('span.user_published')
      else
        expect(page).to have_css('span.user_published')
      end
    end
  end

  private

  def id_css(gig)
    id_class = ".gig-id-#{gig.id}"
  end

  def verify_gig_schedule(gig)
    within ".schedule #{id_css(gig)}" do
      expect(page).to have_css('span.gig-name', text: gig.name)
      expect(page).to have_css('span.gig-note', text: gig.note)
      expect(page).to have_css('span.gig-location', text: gig.location)
    end
  end

  def verify_gig_expired(gig)
    expect(page).to have_css("#{id_css(gig)}.expired")
  end

  def verify_gig_active(gig)
    expect(page).not_to have_css("#{id_css(gig)}.expired")
  end
end
