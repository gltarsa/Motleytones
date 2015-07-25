require 'rails_helper'

describe "User#new page" do
  it "has an page for adding a new band member" do
    visit "/add_user"
    expect(page.title).to eq("Add New Motley Tone")
  end
end

