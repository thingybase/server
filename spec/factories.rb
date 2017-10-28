FactoryGirl.define do
  factory :team_invitation do
    sequence :email { |n| "person#{n}@example.com" }
    name "Bingo Charlie Alpha"
    token { TeamInvitation.random_token }
    expires_at "2017-10-17 23:02:07"
    user
    team
  end

  factory :user do
    name "John Doe"
    sequence :email { |n| "person#{n}@example.com" }
    phone_number "+15555555555"
  end

  factory :team do
    name "The 'A' Team"
    user
  end

  factory :member do
    team
    user
  end

  factory :notification do
    subject "Something happened"
    message "Better take a look at it and get to it. Got that?"
    user
    team
  end

  factory :acknowledgement do
    user
    notification
  end
end
