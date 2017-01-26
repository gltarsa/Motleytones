# frozen_string_literal: true
SOME_PASSWORD ||= "secretpw"
FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    tone_name { "#{Faker::Company.name} Tone" }
    email     { Faker::Internet.email }
    password              SOME_PASSWORD
    password_confirmation SOME_PASSWORD
    admin     { false }
  end

  factory :admin, class: User do
    name      { Faker::Name.name }
    tone_name { "#{Faker::Company.name} Tone" }
    email     { Faker::Internet.email }
    password              SOME_PASSWORD
    password_confirmation SOME_PASSWORD
    admin     { true }
  end
end
