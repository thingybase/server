FactoryGirl.define do
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
