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
      expanded =  "prefix <a href=\"http://html.link.com\">HTML link</a> suffix"
      expect(process_markup(raw_input)).to eql expanded
    end

    it "converts multiple instances of Markdown URLs to HTML" do
      raw_input = "prefix [HTML link1](http://html.link1.com) suffix, [HTML link2](http://html.link2.com), and [link3](link3.com)"
      expanded =  "prefix <a href=\"http://html.link1.com\">HTML link1</a> suffix, <a href=\"http://html.link2.com\">HTML link2</a>, and <a href=\"link3.com\">link3</a>"
      expect(process_markup(raw_input)).to eql expanded
    end

    it "converts the @info token to a mailto link when not part of a word" do
      examples = [
        [ "just @info as a word", "just <a href=\"mailto:info@motleytones.com\">info@motleytones.com</a> as a word" ],
        [ "using (@info) in parentheses", "using (<a href=\"mailto:info@motleytones.com\">info@motleytones.com</a>) in parentheses" ],
        [ "at the end of a sentence: @info.", "at the end of a sentence: <a href=\"mailto:info@motleytones.com\">info@motleytones.com</a>." ]
      ]

      examples.each do |example|
        expect(process_markup(example.first)).to eql example.last
      end
    end

    it "does not convert the @info token when it is part of a word" do
      example = "just @information in a sentence"
      expect(process_markup(example)).to eql example
    end

    it "converts multiple tokens in the line" do
      example = "@info as a word and (@info) in parens and at sentence end: @info."
      expanded = "<a href=\"mailto:info@motleytones.com\">info@motleytones.com</a> as a word and (<a href=\"mailto:info@motleytones.com\">info@motleytones.com</a>) in parens and at sentence end: <a href=\"mailto:info@motleytones.com\">info@motleytones.com</a>."

      expect(process_markup(example)).to eql expanded
    end

    it "performs all conversions in the same line" do
      raw_input = "prefix [HTML link](http://html.link.com) suffix" + "prefix @info suffix"
      expect(process_markup(raw_input)).to eql "prefix <a href=\"http://html.link.com\">HTML link</a> suffix"+"prefix <a href=\"mailto:info@motleytones.com\">info@motleytones.com</a> suffix"
    end
  end
end
