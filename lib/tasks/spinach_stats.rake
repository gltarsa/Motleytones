task stats: 'motley:stats'

namespace :motley do
  task :stats do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << ['Spinach Tests', 'features']
    CodeStatistics::TEST_TYPES << 'Spinach Tests'
  end
end
