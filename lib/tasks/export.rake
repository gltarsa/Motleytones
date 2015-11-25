namespace :db do
  namespace :export do
    desc "Prints User.all in a format suitable for inclusion in seeds.db."
    task user: :environment do
      User.order(:id).all.each do |user|
        puts "User.create(#{user.serializable_hash(except: [ :id, :password_digest, :created_at, :updated_at ])})"
      end
    end

    desc "Prints Gig.all in a format suitable for inclusion in seeds.db."
    task gig: :environment do
      Gig.order(:id).all.each do |gig|
        puts "Gig.create(#{gig.serializable_hash(except: [ :id, :created_at, :updated_at ])})"
      end
    end
  end
end
