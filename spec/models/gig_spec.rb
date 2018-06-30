# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gig, type: :model do
  let(:gig) { FactoryBot.build :gig }

  describe "date" do
    it "is required" do
      gig.date = nil
      expect(gig).not_to be_valid
    end
  end

  describe "user" do
    it "is required" do
      gig.name = nil
      expect(gig).not_to be_valid
    end

    it "must be at least 10 characters long" do
      gig.name = "123445679"
      expect(gig).not_to be_valid
      gig.name = gig.name + "0"
      expect(gig).to be_valid
    end
  end

  describe "note" do
    it "is optional" do
      gig.note = nil
      expect(gig).to be_valid
    end
  end

  describe "location" do
    it "is optional" do
      gig.location = nil
      expect(gig).to be_valid
    end
  end

  describe "note" do
    it "is optional" do
      gig.note = nil
      expect(gig).to be_valid
    end
  end

  describe "date + name"
  it "must be unique" do
    gig.save
    gig2 = FactoryBot.build(:gig, date: gig.date, name: gig.name)
    expect(gig2).not_to be_valid
  end
end
