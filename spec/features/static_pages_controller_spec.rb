describe "static pages" do
  @copyright = "© The Motley Tones. All rights reserved"

  it "has a Home page" do
    visit "/static_pages/home"
    expect(page.title).to eq("The Motley Tones")
    expect(page).to have_content(@copyright)
  end

  it "has an About page" do
    visit "/static_pages/about"
    expect(page.title).to eq("Motley Tones: Past + Present")
    expect(page).to have_content(@copyright)
  end

  it "has a Bios page" do
    visit "/static_pages/bios"
    expect(page.title).to eq("Meet the Tones!")
    expect(page).to have_content(@copyright)
  end

  it "has a Photos page" do
    visit "/static_pages/photos"
    expect(page.title).to eq("Motley Pictures")
    expect(page).to have_content(@copyright)
  end

  it "has a Schedule page" do
    visit "/static_pages/schedule"
    expect(page.title).to eq("Motley Performance Schedule")
    expect(page).to have_content(@copyright)
  end

  it "has a Videos page" do
    visit "/static_pages/videos"
    expect(page.title).to eq("Motley Videos")
    expect(page).to have_content(@copyright)
  end

end
