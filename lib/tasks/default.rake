task :default do
  acceptance_tests_dir = 'spec/acceptance'

  if Dir.exists?(acceptance_tests_dir)
    system "bundle exec rspec #{acceptance_tests_dir}"
    puts '? rspec acceptance tests failed!' if $CHILD_STATUS.exitstatus != 0
  end
end
