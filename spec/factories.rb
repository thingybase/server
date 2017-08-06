FactoryGirl.define do
  factory :user do
    name "John Doe"
    sequence :email do |n|
      "person#{n}@example.com"
    end
  end

  factory :notification do
    subject "Something happened"
    message "Better take a look at it and get to it. Got that?"
    association :user
  end
end