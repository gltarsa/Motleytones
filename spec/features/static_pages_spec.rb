# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'static_pages', type: :feature do
  @copyright = '© The Motley Tones. All rights reserved'

  shared_examples 'it has standard decorations' do |title|
    it 'has a title' do
      expect(page).to have_title(title)
    end

    it 'has a copyright' do
      within 'ul.copyright' do
        expect(page).to have_content(I18n.t('layouts.footer.copyright',
                                            year: Time.now.strftime('%Y')))
      end
    end
  end

  context 'Root page' do
    before { visit '/' }
    it_behaves_like 'it has standard decorations', 'The Motley Tones'

    it 'shows the performance schedule' do
      3.times { FactoryGirl.create(:gig, published: true) }
      visit '/'
      within '.schedule' do
        expect(page).to have_css('li', count: 3)
      end
    end
  end

  context 'About page' do
    before { visit '/about' }
    it_behaves_like 'it has standard decorations', 'Motley Tones: Past + Present'
  end

  context 'Bios page' do
    before { visit '/bios' }
    it_behaves_like 'it has standard decorations', 'Meet the Tones!'
  end

  context 'Photos page' do
    before { visit '/photos' }
    it_behaves_like 'it has standard decorations', 'Motley Pictures'
  end

  context 'Schedule page' do
    before do
      2010.upto(2013).each do |year|
        FactoryGirl.create(:gig, published: true, date: Date.new(year, 7, 10))
      end
      visit '/schedule'
    end

    it_behaves_like 'it has standard decorations', 'Motley Performance Schedule'

    context 'has a gig list' do
      it 'contains a list of gigs' do
        Gig.all.each do |gig|
          within '.main-content' do
            expect(page).to have_css(".gig-id-#{gig.id}")
          end
        end
      end

      it 'a picture separates each year\'s gigs' do
        within '.main-content' do
          2010.upto(2013).each do |year|
            expect(page).to have_css("img.separator-#{year}")
          end
        end
      end
    end
  end

  context 'Videos page' do
    before { visit '/videos' }
    it_behaves_like 'it has standard decorations', 'Motley Videos'
  end
end
