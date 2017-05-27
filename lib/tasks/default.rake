task :default do
  system "bundle exec spinach"
  puts "? spinach failed!" if $?.exitstatus != 0
end
