FactoryGirl.define do
  factory :gig do
    date      { Faker::Date.between(Date.new(2010,7,10), 1.year.from_now) }
    name      { Faker::Name.name }
    link      { Faker::Internet.url }
    note      { Faker::Lorem.words(3) }
    location  { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    published false
  end

  factory :picture do
    date      { Faker::Date.between(Date.new(2010,7,10), 1.year.from_now) }
    name      { "[picture]" }
    link      { Faker::Internet.url }
    published false
  end
end

def between(range)
  # should return a integer between range.max and range.min
  (range.min + range.max) / 2
end
