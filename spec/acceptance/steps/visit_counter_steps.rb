# frozen_string_literal: true

module VisitCounterSteps
  step 'I am not signed in' do
    # gt Ahoy.track_visits_immediately = true
    # gt @initial_count = Visit.count
  end

  step 'I visit the page' do
    visit root_path
  end

  step 'the visit counter increases by 1' do
    expect(Visit.count).to eql(@initial_count + 1)
  end
end

RSpec.configure { |config| config.include VisitCounterSteps }
