PASSWORD ||= "secretpw"
FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    tone_name { "#{Faker::Company.name} Tone" }
    email     { Faker::Internet.email }
    password              PASSWORD
    password_confirmation PASSWORD
    admin      false
  end

  factory :admin, class: User do
    name      { Faker::Name.name }
    tone_name { "#{Faker::Company.name} Tone" }
    email     { Faker::Internet.email }
    password              PASSWORD
    password_confirmation PASSWORD
    admin      true
  end
end
