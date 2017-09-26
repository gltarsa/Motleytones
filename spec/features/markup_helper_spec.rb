# frozen_string_literal: true
require 'rails_helper'
include MarkupHelper
include InfoEmailHelper

# Scenario: Tokens are properly interpolated into schedule lists
#   verify that @info gets interpolated
#   verify that [text](link) gets interpolated
#   verify that when the link markup is  == [Divider](url), then
#          an image url interpolated.

RSpec.describe MarkupHelper do
  def do_compare(examples)
    examples.each do |example|
      expect(process_markup(example[:before])).to eql example[:after]
    end
  end

  describe "#process_markup" do
    let(:new_win)   { 'target="_blank"' }
    let(:mail_link) { '"mailto:info@motleytones.com">info@motleytones.com' }

    context "with Markdown URL syntax" do
      it "converts to HTML" do
        raw_input = "prefix [link](url) suffix"
        expanded =  "prefix <a #{new_win} href=\"url\">link</a> suffix"
        expect(process_markup(raw_input)).to eql expanded
      end

      it "converts multiple instances of Markdown URLs to HTML" do
        examples = [
          { before: "[link](url)",
            after:  "<a #{new_win} href=\"url\">link</a>" },
          { before: "([link](url))",
            after:  "(<a #{new_win} href=\"url\">link</a>)" },
          { before: "prefix [link](url) suffix, [link2](url2), and [link3](url3)",
            after: "prefix <a #{new_win} href=\"url\">link</a> suffix, " \
            "<a #{new_win} href=\"url2\">link2</a>, " \
            "and <a #{new_win} href=\"url3\">link3</a>" }
        ]

        do_compare(examples)
      end
    end

    context "with @info" do
      it "converts the token to a mailto link when not part of a word" do
        examples = [
          { before: "just @info as a word",
            after:  "just <a href=#{mail_link}</a> as a word" },
          { before: "using (@info) in parentheses",
            after:  "using (<a href=#{mail_link}</a>) in parentheses" },
          { before: "at the end of a sentence: @info.",
            after:  "at the end of a sentence: <a href=#{mail_link}</a>." },
          { before: "at the end of a line/section: @info",
            after:  "at the end of a line/section: <a href=#{mail_link}</a>" }
        ]

        do_compare(examples)
      end

      it "does not convert the @info token when it is part of a word" do
        example = "just @information in a sentence"
        expect(process_markup(example)).to eql example
      end

      it "converts multiple @info tokens in the same string" do
        examples = [
          { before: "@info as a word and (@info) in parens and at line end: @info",
            after: "<a href=#{mail_link}</a> as a word and (<a href=#{mail_link}</a>)" \
            " in parens and at line end: <a href=#{mail_link}</a>" }
        ]

        do_compare(examples)
      end
    end

    context "with multiple tokens in the line" do
      it "performs all conversions in the same line" do
        examples = [
          { before: "prefix [link](url) suffix prefix @info suffix",
            after: "prefix <a #{new_win} href=\"url\">link</a> suffix " \
            "prefix <a href=#{mail_link}</a> suffix" }
        ]

        do_compare(examples)
      end

      it "performs all of multiple conversions in the same line" do
        examples = [
          { before: "prefix [link](url) suffix prefix @info suffix ([link2](url2))@info",
            after: "prefix <a #{new_win} href=\"url\">link</a> suffix prefix" \
            " <a href=#{mail_link}</a> suffix " \
            "(<a #{new_win} href=\"url2\">link2</a>)<a href=#{mail_link}</a>" }
        ]

        do_compare(examples)
      end
    end
  end
end
