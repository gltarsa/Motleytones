# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
STARTER_PASSWORD ||= ENV["STARTER_PASSWORD"]

# Create some "starter" accounts
User.create!(
  name: "Greg Tarsa",
  email: "flintz@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Flintz Tone",
  band_start_date: "Fri, 09 Jul 2010" )

User.create!(
  name: "Larry Conklin",
  email: "half@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Half Tone",
  band_start_date: "14 Apr 2012")

User.create!(
  name: "Kat Tarsa",
  email: "ring@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Ring Tone",
  band_start_date: "01 Apr 2011")

# Create some test accounts and performances
unless Rails.env == "production"
  User.create!(
    name: "Non-Admin",
    email: "nonadmin@motley.com",
    admin: false,
    password: STARTER_PASSWORD,
    password_confirmation: STARTER_PASSWORD,
    tone_name: "Not An Admin Tone",
    band_start_date: "Fri, 19 Jul 2010")

  5.times do
    User.create!(
      name:  Faker::Name.name,
      email: Faker::Internet.email,
      admin: (rand.round == 0),
      password: STARTER_PASSWORD,
      password_confirmation: STARTER_PASSWORD,
      tone_name: "#{Faker::Company.name.sub(' Llc', '').sub(' LLC', '').sub(' Inc', '')} Tone",
      band_start_date: Faker::Date.backward(days: 900))
  end

  def day_type
    events = %w[ Festival Market Benefit Party Celebration ]
    kind = %w[ Day Bash Meeting Gathering ].push("")
    "#{events[rand(events.count).round]} #{kind[rand(kind.count).round]}"
  end

  # using #downto so that older gigs will have lower id numbers
  12.downto(0) do |n|
    # Always one New Years gig; we vary the casing so that we can check for proper operation
    # of the clone menu reducing code:
    #   * no case insensitive dups
    #   * digit words (i.e., years, and ordinals)
    #   * leading and trailing spaces
    date = Date.today.years_ago(n)
    Gig.create!(
      published: true,
      date: date.beginning_of_year,
      days: rand(6).round + 1,
      # name: "#{Faker::Commerce.product_name} #{day_type}",

      name: "   [#{date.year} #{%w[New new nEw neW nEW].sample} Years Day Celebration](#{Faker::Internet.url})  123",
      location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}" )

    # Always one New Years Eve gig
    Gig.create!(
      published: true,
      date: date.end_of_year,
      days: rand(6).round + 1,
      name: "   [#{%w[New new nEw neW nEW].sample} Years Eve #{date.year} Party](#{Faker::Internet.url}) 345",
      location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}" )

    # Always one cancelled gig
    Gig.create!(
      published: true,
      date: Date.today.years_ago(n).end_of_year,
      days: rand(6).round + 1,
      name: "Cancelled: [Bad Luck Party](#{Faker::Internet.url})",
      location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}" )

    # Always one canceled (one l) gig
    Gig.create!(
      published: true,
      date: Date.today.years_ago(n).beginning_of_year,
      days: rand(6).round + 1,
      name: "Canceled: [Bad Luk Party](#{Faker::Internet.url})",
      location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}" )

    # Always four Ordinally named gigs (1st, 2nd, 3rd, 4th)
    1.upto(4) do |place_num|
      Gig.create!(
        published: true,
        date: Faker::Date.between(from: Date.today.years_ago(n).beginning_of_year,
                                  to: Date.today.years_ago(n).end_of_year),
        days: rand(6).round + 1,
        name: "[#{place_num.ordinalize} #{Faker::Commerce.product_name}](#{Faker::Internet.url}) #{day_type}",
        location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}" )
    end

    6.times do
      Gig.create!(
        published: (rand(3).round > 0),
        date: Faker::Date.between(from: Date.today.years_ago(n).beginning_of_year,
                                  to: Date.today.years_ago(n).end_of_year),
        days: rand(6).round + 1,
        name: "#{Faker::Commerce.product_name} #{day_type}",
        location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}" )
    end
  end
end
