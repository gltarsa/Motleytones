require 'rails_helper'
include MarkupHelper

# Scenario: Tokens are properly interpolated into schedule lists
#   verify that @info gets interpolated
#   verify that [text](link) gets interpolated
#   verify that when the link markup is  == [Divider](url), then an image url interpolated.

describe MarkupHelper do
  describe "#process_markup" do
    it "converts Markdown URL syntax to HTML" do
      raw_input = "prefix [HTML link](http://html.link.com) suffix"
      expect(process_markup(raw_input)).to eql "prefix <a href=\"http://html.link.com\">HTML link</a> suffix"
    end

    # it "specially interpolates [Picture](<url-text>) as an image url" do
    #   raw_input = "[Divider](http://picture.link.com)"
    #   expect(process_markup(raw_input)).to eql "prefix <a href='http://html.link.com'>HTML link</a> suffix"
    # end

    it "converts the @info token to a mailto:info@motleytones.com link" do
      raw_input = "prefix @info suffix"
      expect(process_markup(raw_input)).to eql "prefix <a href=\"mailto:info@motleytones.com\">info@motleytones.com</a>suffix"
    end

    it "performs all conversions" do
      raw_input = "prefix [HTML link](http://html.link.com) suffix" + "prefix @info suffix"
      expect(process_markup(raw_input)).to eql "prefix <a href=\"http://html.link.com\">HTML link</a> suffix"+"prefix <a href=\"mailto:info@motleytones.com\">info@motleytones.com</a>suffix"
    end
  end
end
