task :default do
  system 'bundle exec spinach'
  puts '? spinach failed!' if $CHILD_STATUS.exitstatus != 0

  system 'bundle exec rspec spec/acceptance'
  puts '? rspec acceptance tests failed!' if $CHILD_STATUS.exitstatus != 0
end
