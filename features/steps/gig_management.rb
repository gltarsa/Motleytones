class Spinach::Features::GigManagement < Spinach::FeatureSteps
  include Helpers

  step 'I am not signed in' do
    visit root_path
  end

  step "I am signed in as a non-admin user" do
    sign_in_non_admin_user
  end

  step "I am signed in as an admin user" do
    sign_in_admin_user
  end

  step 'I look at the Navigation menu' do
    find("li.navigation").hover
  end

  step 'I navigate to the Add Gig page' do
    find("li.navigation").hover
    click_link "Add Gig"
    sync_page
    expect(page.title).to eq("Add New Gig")
  end

  step 'I fill in the gig fields' do
    @gige = FactoryGirl.build(:gig)
    select_date("gig_date",       @gig.date)
    fill_in "gig_name",     with: @gig.name
    fill_in "gig_link",     with: @gig.link
    fill_in "gig_note",     with: @gig.note
    fill_in "gig_location", with: @gig.location
    check "gig_published"
  end

  step 'I click Add Gig' do
    click_button "Add gig"
    sync_page
  end

  step 'the gig is created' do
    gig = Gig.find_by(name: @gig.name)
    expect(gig).not_to be_nil
  end

  step 'I see information for a gig' do
    @id_class = ".gig-id-#{@gig.id}"
    visit "/"
    expect(find("#{@id_class} .gig_name")).to have_content(@gig.name)
    expect(find("#{@id_class} .gig_note")).to have_content(@gig.note)
    expect(find("#{@id_class} .gig_location")).to have_content(@gig.location)
  end

  step 'I see the gig on both schedule pages' do
    i_see_information_for_a_gig
    visit "/schedule"
    expect(find("#{@id_class} .gig_name")).to have_content(@gig.name)
    expect(find("#{@id_class} .gig_note")).to have_content(@gig.note)
    expect(find("#{@id_class} .gig_location")).to have_content(@gig.location)
  end

  step 'there is at least one published gig' do
    @gig = FactoryGirl(:gig, published: true)
  end

  step 'I navigate to the List Gigs page' do
    find("li.navigation").hover
    click_link "List Gigs"
    expect(page.title).to eq("Gig List")
  end

  step 'I click Delete and confirm deletion for that gig' do
    my_accept_alert do
      find(".gig-id-#{@gig.id} form.button_to .delete").click
    end
    sync_page
  end

  step 'the gig is created' do
    gig = Gig.find_by(name: @gig.name)
    expect(gig).to be_nil
  end

  step 'I click Edit for the first gig' do
    pending 'step not implemented'
  end

  step 'I am sent to the Change Gig page' do
    expect(page.title).to eq("Modify Gig")
  end

  step 'I change the gig fields' do
    pending 'step not implemented'
  end

  step 'I click Update' do
    click_on "Update"
    sync_page
  end

  step 'the gig fields are changed' do
    pending 'step not implemented'
  end

  step 'I see the information for the gig' do
    pending 'step not implemented'
  end

  step 'there is at least one unpublished gig' do
    @unpublished_gig = FactoryGirl(:gig, published: false)
  end

  step 'I go to the Schedule Page' do
    visit schedule_path
  end

  step 'I see the published gig' do
    pending 'step not implemented'
  end

  step 'I do not see the unpublished gig' do
    pending 'step not implemented'
  end

  step 'I am not signed in' do
    visit root_path
  end

  step 'I look at the Navigation Menu' do
    find("li.navigation").hover
  end

  step 'I do not see a List Gigs link' do
    expect(page).to have_no_link("List Gigs")
  end

  step 'I do not see an Add Gig link' do
    expect(page).to have_no_link("Add Gig")
  end

  step 'I visit the List Gigs page directly' do
    expect(page).to have_no_link("List Gigs")
  end

  step 'I navigate to the Sign In page' do
    find("li.navigation").hover
    i_click_sign_in
    expect(page.title).to eq("Sign In")
  end

  step 'I see an alert containing "You must be signed in to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be signed in to access that page")
  end

  step 'I see an alert containing "You must be an admin user to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be an admin user to access that page")
  end

  step 'I visit the Add Gig page directly' do
    visit new_gig_path
  end

  step 'I visit the Edit Gig page directly' do
    visit edit_user_path(1) # any user id will work for this test
  end

  step 'I am signed in as a non-admin user' do
    sign_in_non_admin_user
  end

  step 'I am sent to the Profile page' do
    expect(page.title).to eq("Motley User")
    expect(page.text).to match(Regexp.new(".*#{@user.name}.*"))
  end
end
