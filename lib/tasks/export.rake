namespace :db do
  def hash_to_pairs(hash)
    hash.each.collect { |h| "#{h.first}: \"#{h.last}\"" if h.last }.compact.join(",\n  ")
  end

  namespace :export do
    desc "Prints User.all in a format suitable for inclusion in seeds.db."
    task user: :environment do
      User.order(:id).all.each do |user|
        hash = user.serializable_hash(except: [ :id, :password_digest, :created_at, :updated_at ])
        puts "User.create!(#{hash_to_pairs(hash)})"
      end
    end

    desc "Prints Gig.all in a format suitable for inclusion in seeds.db."
    task gig: :environment do
      Gig.order(:id).all.each do |gig|
        hash = gig.serializable_hash(except: [ :id, :created_at, :updated_at ])
        puts "Gig.create!(#{hash_to_pairs(hash)})"
      end
    end

    desc "Prints Visit.all in a format suitable for inclusion in a rails script"
    task visit: :environment do
      Visit.order(:id).all.each do |visit|
        hash = visit.serializable_hash(except: [ :id, :created_at, :updated_at ])
        puts "Visit.create!(#{hash_to_pairs(hash)})"
      end
    end
  end
end
