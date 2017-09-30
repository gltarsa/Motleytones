require 'support/export_helper'
namespace :db do
  include ExportHelper

  namespace :export do
    desc 'Prints User.all in a format suitable for inclusion in seeds.db'
    task user: :environment do
      export_to_stdout(klass: User, extra_exceptions: [:password_digest])
    end

    desc 'Prints Gig.all in a format suitable for inclusion in seeds.db'
    task gig: :environment do
      export_to_stdout(klass: Gig)
    end

    desc 'Prints Ahoy::Event.all in a format suitable for inclusion in a rails script'
    task events: :environment do
      export_to_stdout(klass: Ahoy::Event)
    end

    desc 'Prints Visit.all in a format suitable for inclusion in a rails script'
    task visit: :environment do
      export_to_stdout(klass: Visit)
    end
  end
end
