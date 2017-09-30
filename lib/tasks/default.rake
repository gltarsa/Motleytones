task :default do
  system 'bundle exec spinach'
  puts '? spinach failed!' if $CHILD_STATUS.exitstatus != 0
end
