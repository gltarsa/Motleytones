require 'rails_helper'

describe "User#new page" do
  it "has an page for adding a new band member" do
    visit "/users/new"
    expect(page.title).to eq("Add New Motley Tone")
  end
end

