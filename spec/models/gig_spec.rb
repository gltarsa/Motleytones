require 'rails_helper'

# - Gig name is required
# - Gig name must be at least 10 characters long
# - records that do not have published == true will not be displayed.
# - Output rules:
#     * [name] is required
#     * [date] is required
#     * [note] is optional
#     * [location] is optional
#     * basic output: [date], [name] - [note], [location]
#     * if there is a [location] then it is preceded by ", "
#     * if there is a [note]     then it is preceded by " - "
#     * within [name] and [note]
#         "@info" is replaced with with a URL to mailto:info@motleytones.com
#         "[text](url)" is replaced with '<a href="url">text</a>'
#     * if [name] == "[Picture]" then
#          [note] is required and is the URL of the picture to display and
#          "<h2> YYYY Performance Schedule" should be displayed, where YYYY is the 4-digit year in [date]
#
# Key Examples for test:
#   - date, name, location (no note)
#       Jan 9, Corporate Luncheon, Durham NC
#   - date, name, location w/ url, (no note, no location)
#       Mar 1, Garner Talent Showcase - [Garner Performing Arts Center](http://www.garnerperformingartscenter.com)
#   - date, name w/ url, note, location
#       Apr 5, [Downtown Cary Farmer's Market](http://caryfarmersmarket.com) - Opening Day, Cary NC
#   - date, name (no note, no location)
#       May 18, Private Party
#   - date, name w/ info-email
#       Jun 23, Private Party - @info
#   - date, name w/ url, note w/ url, location
#       Jun 24, [Tir Na Nog Running Club](http://www.nogrunclub.com/charity) - Charity event: [Wake Meals on Wheels](http://wakemow.org), Raleigh

RSpec.describe Gig, type: :model do
  before(:each) do
    @gig = FactoryGirl.create :gig
  end

  describe "basic validation" do
    it "checks gig validity" do
      expect(@gig).to be_valid
    end

    it "date is required" do
      @gig.date = nil
      expect(@gig).not_to be_valid
    end

    it "name is required" do
      @gig.name = nil
      expect(@gig).not_to be_valid
    end

    it "name must be at least 10 characters long" do
      @gig.name = "123445679"
      expect(@gig).not_to be_valid
      @gig.name = @gig.name + "0"
      expect(@gig).to be_valid
    end

    it "note is optional" do
      @gig.note = nil
      expect(@gig).to be_valid
    end

    it "location is optional" do
      @gig.location = nil
      expect(@gig).to be_valid
    end

    it "note is optional" do
      @gig.note = nil
      expect(@gig).to be_valid
    end
  end
end
