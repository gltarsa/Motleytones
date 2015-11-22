require 'rails_helper'
include DateDisplayHelper

# Scenario: dates in a Motley Schedule should display in minimal space
#  * single day dates should display as: MM DD  (i.e., Apr 12)
#  * multi day dates should display as MM DD1-DD2 if in the same month  (i.e., Jun 1-3)
#  * multi day dates should display as MM DD1-MM DD2 if in diferent months (i.e., May 31-Jun 2)

describe DateDisplayHelper do
  let(:date1) { Date.parse("12 Apr 1984") }

  describe "#date_range" do
    it "displays a single day as MM DD" do
      expect(date_range(date1, 1)).to eql "Apr 12"
    end

    it "single digit days are not padded" do
      expect(date_range(date1 - 3, 1)).to eql "Apr 9"
    end

    it "displays a single month day range as MM DD1-DD2" do
      expect(date_range(date1, 3)).to eql "Apr 12-15"
    end

    it "displays a multi-month day range as MM DD1-MM DD2" do
      expect(date_range(date1, 30)).to eql "Apr 12-May 12"
    end
  end
end
