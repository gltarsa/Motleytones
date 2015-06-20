describe "static pages" do
  @copyright = "© The Motley Tones. All rights reserved"

  it "has a Root page" do
    visit "/"
    expect(page.title).to eq("The Motley Tones")
    expect(page).to have_content(@copyright)
  end

  it "has an About page" do
    visit "/about"
    expect(page.title).to eq("Motley Tones: Past + Present")
    expect(page).to have_content(@copyright)
  end

  it "has a Bios page" do
    visit "/bios"
    expect(page.title).to eq("Meet the Tones!")
    expect(page).to have_content(@copyright)
  end

  it "has a Photos page" do
    visit "/photos"
    expect(page.title).to eq("Motley Pictures")
    expect(page).to have_content(@copyright)
  end

  it "has a Schedule page" do
    visit "/schedule"
    expect(page.title).to eq("Motley Performance Schedule")
    expect(page).to have_content(@copyright)
  end

  it "has a Videos page" do
    visit "/videos"
    expect(page.title).to eq("Motley Videos")
    expect(page).to have_content(@copyright)
  end

end
