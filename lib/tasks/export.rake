namespace :export do
  desc "Prints User.all in a format suitable for inclusion in seeds.db."
  task seeds_format: :environment do
    User.order(:id).all.each do |user|
      puts "User.create(#{user.serializable_hash(except: [ :id, :password_digest, :created_at, :updated_at ])})"
    end
  end
end
