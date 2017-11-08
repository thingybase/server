# Set phone numbers to be US only, for now ...
Faker::Config.locale = 'en-US'

FactoryBot.define do
  factory :team_invitation do
    email { Faker::Internet.unique.email }
    name { Faker::Name.name }
    token { TeamInvitation.random_token }
    user
    team
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    factory :user_with_phone_number do
      phone_number { Faker::PhoneNumber.unique.cell_phone }
    end
  end

  factory :team do
    name { Faker::Superhero.name }
    user
  end

  factory :member do
    team
    user
  end

  factory :notification do
    subject { Faker::Hipster.sentence }
    message { Faker::Hipster.paragraph }
    user
    team
  end

  factory :acknowledgement do
    user
    notification
  end
end
