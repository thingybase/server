# Set phone numbers to be US only, for now ...
Faker::Config.locale = 'en-US'

FactoryBot.define do
  factory :api_key do
    name { Faker::Name.name }
    secret ApiKey.generate_secret
    user
  end

  factory :phone_number_claim do
    phone_number { Faker::PhoneNumber.unique.cell_phone }
    code { PhoneNumberClaim.random_code }
    user
  end

  factory :invitation do
    email { Faker::Internet.unique.email }
    name { Faker::Name.name }
    token { Invitation.random_token }
    user
    account
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    factory :user_with_phone_number do
      phone_number { Faker::PhoneNumber.unique.cell_phone }
    end
  end

  factory :account do
    name { Faker::Superhero.name }
    user
  end

  factory :member do
    account
    user
  end

  factory :notification do
    subject { Faker::Hipster.sentence }
    message { Faker::Hipster.paragraph }
    user
    account
  end

  factory :acknowledgement do
    user
    notification
  end
end
