# Set phone numbers to be US only, for now ...
Faker::Config.locale = 'en-US'

FactoryBot.define do
  factory :subscription do
    account
    user
    expires_at { DateTime.current }
    plan_type { "FreePlan" }
  end

  factory :loanable_list_member_request do
    user
    loanable_list
  end

  factory :loanable_list_member do
    user
    loanable_list
  end

  factory :loanable_item do
    loanable_list
    user
    account
    item
  end

  factory :loanable_list do
    account
    user
    name { "#{Faker::Name.unique.name}'s stuff" }
  end

  factory :movement do
    account
    user
    move
    origin { build(:item, container: true) }
    destination { build(:item, container: true) }
  end

  factory :move do
    account
    user
  end

  factory :member_request do
    account
    user
  end

  factory :vector_asset do
    path { VectorAsset.find("icons/folder.svg").path }
  end

  factory :item do
    name { Faker::Name.name }
    account
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

  factory :label do
    text { Faker::Hipster.sentence }
    user
    account
    item
  end
end
