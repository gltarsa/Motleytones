# frozen_string_literal: true

FactoryBot.define do
  factory :gig do
    date      { Faker::Date.between(Date.new(2010, 7, 10), 1.year.from_now) }
    name      { proper_length_name }
    note      { "#{Faker::Lorem.words(3)} #{Faker::Internet.url} #{Faker::Lorem.words(2)}" }
    location  { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    published { false }
  end

  factory :picture do
    date      { Faker::Date.between(Date.new(2010, 7, 10), 1.year.from_now) }
    name      { "[picture]" }
    note      { "#{Faker::Internet.url}/image.png" }
    published { false }
  end
end

# ensures that faked dates are in a specified range
def between(range)
  (range.min + range.max) / 2
end

# ensures that faked names are not invalid due to length
def proper_length_name
  name = ''
  name = "#{Faker::Commerce.product_name} #{day_type}" until name.length > 13
  name
end

def day_type
  events = %w[Festival Market Benefit Party Celebration]
  kind = %w[Day Bash Meeting Gathering Event]
  "#{events[rand(events.count).round]} #{kind[rand(kind.count).round]}"
end
