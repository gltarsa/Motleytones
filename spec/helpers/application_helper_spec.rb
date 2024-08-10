# frozen_string_literal: true

require 'rails_helper'
include ApplicationHelper

# Scenario: We need to be able to identify gigs in the Gig List that have been cancelled.
#           Currently, we do that by putting "Cancelled" in the name.

RSpec.describe ApplicationHelper do
  let(:canceled_gigs) do
    %w(cancelled Cancelled Canceled: [Canceled] (Canceled)).map do |n|
      FactoryBot.create(:gig, name: "#{n} #{Faker::Commerce.product_name} #{day_type}")
    end
  end

  let(:active_gigs) do
    ['Land of Cancellation', 'Normal Gig', 'cancel cancel cancel'].map do |n|
      FactoryBot.create(:gig, name: n)
    end
  end

  describe "#canceled(gig)" do
    it 'returns true when the gig has a cancel token in the name' do
      canceled_gigs.each {|gig| expect(canceled(gig)).to be true}
    end

    it 'returns false when the gig has no cancel token in the name' do
      active_gigs.each {|gig| expect(canceled(gig)).to be false}
    end
  end
end
