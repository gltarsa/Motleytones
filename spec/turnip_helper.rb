# Dir.glob('spec/acceptance/support/**/*.rb') { |f| load f, true }
Dir.glob('spec/steps/**/*_steps.rb') { |f| load f, true }
