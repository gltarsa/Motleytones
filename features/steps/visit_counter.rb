class Spinach::Features::VisitCounter < Spinach::FeatureSteps
  step 'I am not signed in' do
    # @ahoy = Ahoy::Tracker.new
    Ahoy.track_visits_immediately = true

    visit root_path
    @initial_count = Visit.count
  end

  step 'a new visitor visits the page' do
    visit destroy_user_session_path
    visit root_path
  end

  step 'the visit counter increases by 1' do
    pending "Need to find out right way to test this"
    puts "Visit count ] #{Visit.count}"
    expect(Visit.count).to eql(@initial_count + 1)
  end
end
