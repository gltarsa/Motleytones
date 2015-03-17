describe "static pages" do
  it "has a home page" do
    visit "/static_pages/home"
    expect(page).to have_css("title", text: "Motley Tones")
  end
end
