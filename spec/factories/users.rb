PASSWORD ||= "secretpw"
FactoryGirl.define do
  factory :user do
    name      "Brantley Ill"
    tone_name "Mono Tone"
    email      "somewhere@around.here.com"
    password              PASSWORD
    password_confirmation PASSWORD
    admin      false
  end

  factory :admin, class: User do
    name      "Rex Staffley"
    tone_name "King Tone"
    email      "elsewhere@around.here.com"
    password              PASSWORD
    password_confirmation PASSWORD
    admin      true
  end
end
