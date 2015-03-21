describe "static pages" do
  it "has a Home page" do
    visit "/static_pages/home"
    expect(page.title).to eq("The Motley Tones")
  end

  it "has an About page" do
    visit "/static_pages/about"
    expect(page.title).to eq("Motley Tones: Past + Present")
  end

  it "has a Bios page" do
    visit "/static_pages/bios"
    expect(page.title).to eq("Meet the Tones!")
  end

  it "has a Photos page" do
    visit "/static_pages/photos"
    expect(page.title).to eq("Motley Pictures")
  end

  it "has a Schedule page" do
    visit "/static_pages/schedule"
    expect(page.title).to eq("Motley Performance Schedule")
  end

  it "has a Videos page" do
    visit "/static_pages/videos"
    expect(page.title).to eq("Motley Videos")
  end

end
