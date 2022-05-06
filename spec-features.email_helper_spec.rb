# frozen_string_literal: true

require 'rails_helper'

# Scenario:
#  Mail sent using ActionMailer is configured correctly

RSpec.describe ActionMailer::Base do
  describe 'hello' do
    let(:name) { 'John' }
    let(:mail) { described_class.hello(name).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eql('Hello')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['send_to@example.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['noreply@exmpale.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(name)
    end
  end
end
