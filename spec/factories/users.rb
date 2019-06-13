# frozen_string_literal: true

SOME_PASSWORD ||= 'secretpw'.freeze

FactoryBot.define do
  factory :user do
    name      { Faker::Name.name }
    tone_name { "#{Faker::Company.name} Tone" }
    email     { Faker::Internet.email }
    password  { SOME_PASSWORD }
    password_confirmation { SOME_PASSWORD }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
