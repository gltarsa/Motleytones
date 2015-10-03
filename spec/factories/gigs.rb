FactoryGirl.define do
  factory :gig do
    date      { Faker::Date.between(Date.new("7/9/2010", 1.year.from.now)) }
    name      { Faker::Name.name }
    link      { Faker::Internet.url }
    note      { Faker::Lorem.words(3) }
    location  { "#{Faker::Name}, #{Faker::state_abbr}" }
    published false
  end

  factory :picture do
    date      { Faker::Date.between(Date.new("7/9/2010", 1.year.from.now)) }
    name      { "[picture]" }
    link      { Faker::Internet.url }
    published false
  end
end

def between(range)
  # should return a integer between range.max and range.min
  (range.min + range.max) / 2
end
