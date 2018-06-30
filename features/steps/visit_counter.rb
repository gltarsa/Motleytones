# frozen_string_literal: true

class Spinach::Features::VisitCounter < Spinach::FeatureSteps
  step 'I am not signed in' do
    Ahoy.server_side_visits = true # for testing purposes
    @initial_count = Visit.count
  end

  step 'I visit the page' do
    visit root_path
  end

  step 'the visit counter increases by 1' do
    expect(Visit.count).to eql(@initial_count + 1)
  end
end
